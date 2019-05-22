require 'sinatra'
require 'sass'
require_relative 'user'
require_relative 'student'
require_relative 'comment'
require_relative 'database_seed'
require 'sinatra/reloader' if development?



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

get '/video' do 
    erb :video
end

get '/about' do 
    erb :about
end

get '/contact' do 
    erb :contact
end





helpers do
def current_user
    @current_user ||= User.all(:username => session[:user_id]) if session[:user_id]
end

def logged_in?
    !!current_user
end
end

