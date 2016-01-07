require "sinatra/activerecord"
require "sinatra"


configure(:development){set :database, "sqlite3:herokudb.sqlite3"}

require './models'

get '/' do
	@posts = Post.all
	erb :index

end	

get '/newpost' do
	erb :newpost
end

post '/newpost' do
	@posts = Post.create(title: params[:title], body: params[:body])
	redirect '/'
end	


get "/signup" do
	erb :signup
end

get "/login" do
	erb :login
end

get "/logout" do
	session.clear
	redirect to("/logout_successful")
end