# app.rb
require 'rubygems'
require 'bundler/setup'
Bundler.require

get '/' do
	file_contents = File.read('todo.txt')
	lines = file_contents.split("\n")
	@tasks = []
	@undated_tasks = []
	@dated_tasks = []
	lines.each do |line|
		task, date = line.split("-")
		unless blank? date
			@dated_tasks << [task, date]
		else
			@undated_tasks << [task, date]
		end
	end
	@tasks = @dated_tasks.push(*@undated_tasks)
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
