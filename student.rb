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
  property :student_id, String
  property :firstname, String, :required => true
  property :lastname, String, :required => true
  property :birthday, Date, :required => true
  property :address, String
  property :major, String
  property :personality, String
  property :notes, Text
  property :created_at, DateTime
end


DataMapper.finalize
DataMapper.auto_migrate!

get '/students' do
    erb :'/students/index'
end
