require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
    enable :sessions
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  get '/signup' do
    if !logged_in?
        erb :"users/new"
    else
        redirect "/shows"
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save && !params[:username].empty? && !params[:email].empty?
        @user.save
        session[:user_id] = @user.id
        redirect '/shows'
    else
        redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
        redirect "/shows"
    else 
      erb :"/users/login"
    end
  end
  
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/shows'
    else
        redirect '/signup'
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @shows =  @user.shows
    erb :'/users/show'
  end

  get '/shows' do
    @shows = Show.all 
    if logged_in?
      erb:"shows/shows"
    else
      redirect "/login"
    end
  end

  get '/shows/new' do
    if logged_in?
        erb :'/shows/new'
    else
        redirect "/login"
    end
  end

  post '/shows' do
    if !params[:show_title].empty?
      @show = Show.create(show_title: params[:show_title])
    else
        redirect "/shows/new"
    end

    if logged_in?
        @show.user_id = current_user.id
        @show.save
    end
    redirect "/shows"
  end

  get '/shows/:id' do
    @show = Show.find(params[:id])
    if logged_in?
    erb :"/shows/show"
  else
    redirect "/login"
  end 
end

  get '/shows/:id/edit' do
    if logged_in?
      @show = Show.find(params[:id])
    if @show.user_id == current_user.id
      erb :'shows/edit'
    else
      redirect "/shows"
    end
  end
end

  patch '/shows/:id' do
    @show = Show.find(params[:id])
    @show.update(show_title: params[:show_title])
  if !@show.show_title.empty?
    redirect "/shows/#{@show.id}"
  else
    redirect "/shows/#{@show.id}/edit"
  end
end

  delete '/shows/:id/delete' do
    @show = Show.find(params[:id])
  if logged_in? && @show.user_id == current_user.id
      @show.destroy
      redirect "/shows"
  else
      redirect "/login"
  end
end
end