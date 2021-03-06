require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'sinatra'
#require_relative 'main'

#require 'data_mapper'
configure :development, :test do 
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do 
  DataMapper.setup(:default,ENV['DATABASE_URL']) 
end


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
    if user && user.password == params[:password]
        session[:user_id] = user.username
        redirect "/"
    else
        session[:message] = "Username/password you entered doesn't match! Try again or sign up."
        redirect "/login"
    end
end

get '/logout' do
    session.destroy
    redirect "/login"

end
