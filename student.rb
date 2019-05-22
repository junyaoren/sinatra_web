require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'sinatra'
#require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Student
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

get '/students' do
    @message = session.delete(:message)
    erb :'/students/index'
end
