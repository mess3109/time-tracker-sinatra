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
      user = User.create(params[:user])
      if user.save
        redirect "/login"
      else
        flash[:message] = "Required field missing"
        redirect "/signup"
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
      current_user = User.find_by(username: params[:username])
      if current_user && current_user.authenticate(params[:password])
        session[:user_id] = current_user.id
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
