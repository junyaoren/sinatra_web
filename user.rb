require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'sinatra'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class User
  include DataMapper::Resource
  property :id, Serial

  property :username, String, :required => true, :unique => true
  validates_uniqueness_of :username
  #:message => "The username is taken."

  property :password, String, :required => true
  validates_length_of :password, :min => 5
  #:message => "The password is too short: at least 5 characters."
end


DataMapper.finalize
DataMapper.auto_migrate!

get '/signup' do
    @message = session.delete(:message)
    erb :'/users/signup'
end

post '/signup' do 
    user = User.new(params)
    if user.save
        session[:user_id] = user.username
        redirect "/"
    else
      session[:message] = user.errors.on(:password)[0] if user.errors.on(:password)
      session[:message] = user.errors.on(:username)[0] if user.errors.on(:username)
      redirect "/signup"
    end        
end

get '/login' do
    @message = session.delete(:message)
    erb :'/users/login'
end

post '/login' do
    user = User.first(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.username
        redirect "/"
    else
        session[:message] = "That didn't work... Try logging in again or sign up if you don't have an account yet."
        redirect "/login"
    end
end

get '/logout' do
    session.destroy
    redirect "/login"

end

get '/users/:slug' do
    authenticate_user
    @user = User.find_by_slug(params[:slug])
    if @user.id == current_user.id
        erb :'/users/index'
    else
        redirect "/places/index"
    end
end