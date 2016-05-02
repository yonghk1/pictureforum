require 'pg'
require 'pry'
require 'BCrypt'

module Sinatra

  class Server < Sinatra::Base
    set :method_override, true

    def current_user
      @current_user ||= conn.exec("SELECT * FROM users WHERE id=#{session[:user_id]}").first
    end

    def logged_in?
      current_user
    end

    get "/" do
      erb :index
    end

    get '/about' do
      erb :about
    end

    get '/signup' do
      erb :signup
    end

    post '/signup' do
      @user_name = params[:user_name]
      @email = params[:mail]
      @password = BCrypt::Password::create(params[:password])

      db.exec_params(
        "INSERT INTO users (user_name, email, password) VALUES ($1, $2, $3)",[@user_name, @email, @password]
      )

      redirect '/'
    end

    delete '/posts' do
      id = params['post_id'].to_i
      db.exec_params("DELETE FROM posts WHERE id = $1", [id])
      redirect to '/posts'
    end

    get '/login' do
      erb :login
    end

    post '/login' do
# get the user from database
      @user_name = params[:user_name]
      @password = params[:password]
      @user = db.exec_params("SELECT * FROM users WHERE user_name = $1 LIMIT 1", [@user_name]).first
      if @user && BCrypt::Password::new(@user["password"]) == params[:password]
        "Welcome, #{@user_name}!"
      else
        "Incorrect user ID or password. Try again."
      end
    end

    get '/post' do
      erb :post
    end

    post '/post' do
      @title = params[:title]
      @image = params[:image]
      @content = params[:content]

      db.exec_params("INSERT INTO posts (title, img_url, content) VALUES ($1, $2, $3)", [@title, @image, @content])
      redirect to '/posts'

    end


    get '/posts' do
      request = db.exec("SELECT * FROM posts")
      @posts = request.to_a
      erb :posts
    end



    post '/posts' do
      # request = db.exec("SELECT * FROM posts")
      # @posts = request.to_a
      # erb :posts
    end

    def db
      if ENV["RACK_ENV"] == "production"
        PG.connect(
          dbname: ENV["POSTGRES_DB"],
          host: ENV["POSTGRES_HOST"],
          password: ENV["POSTGRES_PASS"],
          user: ENV["POSTGRES_USER"]
        )
      else
        PG.connect(dbname: "wonders_of_world")
      end
    end



  end
end
