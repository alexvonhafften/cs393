# app.rb
require 'rubygems'
require 'bundler/setup'
Bundler.require
require './models/TodoItem'

# how we want to wire the database
ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
	database: 'db/development.db',
	encoding: 'utf8'
)

get '/' do
	# need to interact with the database
	@task = TodoItem.all.order(:due_date)
	erb :index
end

post '/' do
	TodoItem.create(params)
	redirect '/'
end

helpers do
	def blank?(x)
		x.nil? || x == ""
	end
end
