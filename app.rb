# app.rb
require 'rubygems'
require 'bundler/setup'
Bundler.require
require './models/TodoItem'
require './models/User'

if ENV['DATABASE_URL']
	ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
	ActiveRecord::Base.establish_connection(
		:adapter =>'sqlite3',
		:database => 'db/development.db',
		:encoding => 'utf8'
	)
end

get '/' do
	@users = User.all.order(:name)
	erb :user_list
end

get '/:user' do
	@user = User.find(params[:user])
	@tasks = @user.todo_items.order(:due_date)
	erb :todo_list
end

post '/new_user' do
	@user = User.create(params)
	redirect '/'
end

get '/delete_user/:user' do
	User.find(params[:user]).destroy
	redirect '/'
end

post '/:user/new_item' do
	User.find(params[:user]).todo_items.create(description: params[:description], due_date: params[:due_date])
	redirect "/#{params[:user]}"
end

get '/delete_item/:item' do
	@todo_item = TodoItem.find_by(id: params[:item])
	@todo_item.destroy
	redirect '/'
end

helpers do
	def blank?(x)
		x.nil? || x == ""
	end
end
