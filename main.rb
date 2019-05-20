require 'sinatra'
require 'sinatra/reloader' if development?

class ApplicationController < Sinatra::Base

	configure do
    set :public_folder, './public'
    set :views, './views'
    enable :sessions
    set :session_secret, 'password_security'
    end

    get '/styles.css' do 
        scss :styles
    end

	get '/' do
		erb :index
	  
	end



	helpers do
    def current_user
        @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end
  end

end