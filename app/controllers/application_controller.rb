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
        redirect "/tweets"
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

get '/shows' do
  @shows = Show.all 
  if logged_in?
    erb:"shows/shows"
  else
    redirect "/login"
  end
end
end