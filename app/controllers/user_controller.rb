class UserController < ApplicationController

    #Create User
    get '/signup' do
      if logged_in?
        redirect to "/tasks"
      else
        erb :'users/signup'
      end
    end

    post '/signup' do
      #all fields required for signup
      if params[:user][:name].empty? || params[:user][:username].empty? || params[:user][:password].empty?
        flash[:message] = "Missing field"
        redirect "/signup"
      else
        user = User.create(params[:user])
        redirect "/login"
      end
    end

    get '/login' do
      if logged_in?
        redirect to "/tasks"
      else
        erb :'users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tasks"
      else
        flash[:message] = "Incorrect username or password"
        redirect "/login"
      end
    end

    get '/logout' do
      session.clear
      redirect "/"
    end

end
