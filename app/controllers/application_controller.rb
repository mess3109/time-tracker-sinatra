require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

end
