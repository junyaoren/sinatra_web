require 'sinatra'
require 'sinatra/reloader' if development?

class ApplicationController < Sinatra::Base

	get '/' do
	  "hello to junyao's world"
	end
end