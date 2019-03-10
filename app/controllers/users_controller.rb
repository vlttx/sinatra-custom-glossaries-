class UsersController < ApplicationController

	get '/login' do
	erb :login	
	end

	post '/login' do
	@user = User.find_by(email: params[:email])
	if @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect "/users/#{@user.id}"

	else

	end


	get '/users/:id' do
		"this will be the show route"
	end
end