# app.rb
require 'rubygems'
require 'bundler/setup'
Bundler.require

get '/' do
	file_contents = File.read('todo.txt')
	lines = file_contents.split("\n")
	@tasks = []
	lines.each do |line|
		task, date = line.split("-")
		@tasks << [task, date]
	end
	erb :index
end

post '/' do
	File.open("todo.txt", "a") do |file|
		if blank? params[:date]
			file.puts "#{params[:task]}"
		else
			file.puts "#{params[:task]} - #{params[:date]}"
		end
		redirect '/'
	end
end

helpers do
	def blank?(x)
		x.nil? || x == ""
	end
end
