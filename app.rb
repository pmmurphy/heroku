require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"

enable :sessions

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

post '/user_login_attempt' do   
	@user = User.where(username: params[:username]).first   
	if @user && @user.password == params[:password]    
		session[:user_id] = @user.id    
		flash[:notice] = "You've been signed in successfully."   
	else     
		flash[:notice] = "There was a problem signing you in."   
	end   
	redirect "/newpost"
end


get "/login" do
	erb :login
end

get "/logout" do
	session.clear
	redirect to("/logout_successful")
end

get "/main" do
	# @user = User.find(session[:user_id])
	@usersALL = User.all
	@user = User.find(session[:user_id])
	# @user = User.find(1)

	@postsAll = Post.all

	erb :main
end

# def current_user
# 	if session[:user_id]
# 		@current_user = User.find(session[:user_id])
# 	 end
# 	end	
