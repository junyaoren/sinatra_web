require 'sinatra'
require_relative '../main'

class UserController < Sinatra::Base
  
  get '/signup' do
      @message = session.delete(:message)
      erb :'/users/new'
  end

  post '/signup' do 
      user = User.new(params)
      if user.save
          session[:user_id] = user.id
          redirect "/places"
      else
          session[:message] = "Please fill out all of the fields and make sure your password is longer than 8 characters."
          redirect "/signup"
      end        
  end

  get '/login' do
      @message = session.delete(:message)
      erb :'/users/login'
  end

  post '/login' do
      user = User.find_by(:name => params[:name])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/places"
      else
          session[:message] = "That didn't work... Try logging in again or sign up if you don't have an account yet."
          redirect "/login"
      end
  end

  get '/logout' do
      authenticate_user
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

  

end
