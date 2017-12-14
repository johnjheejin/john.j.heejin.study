require 'sinatra'
require 'csv'

get '/' do 
	erb :index
end

get '/vote' do

	@name = params[:name]
	@vote = params[:vote]

	CSV.open("vote.csv", "a+") do |csv|
		csv << [@name, @vote]
	end

	erb :vote
end

get '/result' do

	@list = Array.new

	CSV.foreach("vote.csv", encoding: "UTF-8") do |eachrow|
		@list << eachrow
	end

	erb :result
end



before do
	p '-------------------------'
	p params
	p '-------------------------'
end

