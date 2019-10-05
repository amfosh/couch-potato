class UsersController < ApplicationController
    
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
end