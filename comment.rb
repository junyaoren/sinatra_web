require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'sinatra'
require 'dm-timestamps'
#require_relative 'main'

#require 'data_mapper'
configure :development, :test do 
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do 
  DataMapper.setup(:default,ENV['DATABASE_URL']) 
end

class Comment
  include DataMapper::Resource
  property :id, Serial

  property :username, String, :required => true

  property :title, String, :required => true
  validates_length_of :title, :min => 1
  
  property :content, Text, :required => true
  validates_length_of :content, :min => 10

  property :created_at, DateTime
end


DataMapper.finalize
DataMapper.auto_migrate!

get '/comments' do
  erb :'/comments/index'
end

post '/comments' do
  @comment = Comment.new(params)
  @comment.username = session[:user_id] || "stranger"
  if @comment.save
    redirect "/comments/#{@comment.id}"
    #@comment = nil
  else
    session[:message] = @comment.errors.on(:content)[0] if @comment.errors.on(:content)
    session[:message] = @comment.errors.on(:title)[0] if @comment.errors.on(:title)
    session[:comment_title] = @comment.title
    session[:comment_content] = @comment.content
    redirect "/comments/new"
  end
end

get '/comments/new' do
  @title = session.delete(:comment_title)
  @content = session.delete(:comment_content)
  @message = session.delete(:message)

  erb :'/comments/new'
end

get '/comments/:id' do
  @comment = Comment.first(:id => params[:id])
  erb :'/comments/show'
end














