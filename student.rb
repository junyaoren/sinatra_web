require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'sinatra'
require_relative 'main'
#require 'data_mapper'



class Student
  include DataMapper::Resource
  property :id, Serial
  property :student_id, String, :required => true
  validates_uniqueness_of :student_id, :message => "Student_ID already taken!"
  property :firstname, String, :required => true
  property :lastname, String, :required => true
  property :birthday, Date
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

post '/students' do
  @student = Student.new(params)
  if @student.save
    redirect "/students/#{@student.id}"
  else

    session[:message] = @student.errors.on(:birthday)[0] if @student.errors.on(:birthday)
    session[:message] = @student.errors.on(:lastname)[0] if @student.errors.on(:lastname)
    session[:message] = @student.errors.on(:firstname)[0] if @student.errors.on(:firstname)
    session[:message] = @student.errors.on(:student_id)[0] if @student.errors.on(:student_id)
    session[:params] = params
    redirect "/students/new"
  end
end

delete '/students/:id' do
  @student = Student.first(:id => params[:id])
  @student.destroy
  redirect '/students'
end

get '/students/new' do
  @message = session.delete(:message)
  @unfinished = session.delete(:params) || Hash.new
  erb :'students/new'
end

get '/students/:id' do
  @student = Student.first(:id => params[:id])
  erb :'/students/show'
end

get '/students/:id/edit' do
  @student = Student.first(:id => params[:id])
  erb :'/students/edit'
end

put '/students/:id' do
  @student = Student.first(:id => params[:id])
  params.delete(:_method)


  if @student.update(params)
    redirect "/students/#{@student.id}"
  else
    session[:message] = @student.errors.on(:birthday)[0] if @student.errors.on(:birthday)
    session[:message] = @student.errors.on(:lastname)[0] if @student.errors.on(:lastname)
    session[:message] = @student.errors.on(:firstname)[0] if @student.errors.on(:firstname)
    session[:message] = @student.errors.on(:student_id)[0] if @student.errors.on(:student_id)
    session[:params] = params
    @message = session.delete(:message)
    erb :'/students/edit'
  end

end

