class GlossariesController < ApplicationController
	get '/glossaries/new' do 
		erb :'glossaries/new'
	end

	post '/glossaries' do
		if !logged_in?
			redirect '/'
		end

		if params[:content] != ""
			@glossary = Glossary.create(title: params[:title], user_id: current_user.id)
			redirect "/glossaries/#{@glossary.id}"
		else
			redirect '/glossaries/new'
		end
	end

	get '/glossaries' do 
		@glossaries = Glossary.all
		erb :'glossaries/index'
	end

	get '/glossaries/:id' do 
		set_glossary
		erb :'glossaries/show'
	end

	get "/glossaries/:id/edit" do
		set_glossary
		if logged_in?
			if @glossary.user == current_user
				erb :'glossaries/edit'
			else
				redirect "users/#{current_user.id}"
			end
		else
			redirect '/'

		end
	end

	patch '/glossaries/:id' do 
		set_glossary
		if logged_in?
			if @glossary.user == current_user
				@glossary.update(title: params[:params])
				redirect "/glossaries/#{@glossary.id}"
			else
				redirect "users/#{current_user.id}"
			end
		else
			redirect '/'
		end
	end

	private

	def set_glossary
		@glossary = Glossary.find(params[:id])
	end



end