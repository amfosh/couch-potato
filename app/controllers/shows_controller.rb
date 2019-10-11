class ShowsController < ApplicationController
  
  get '/shows' do
    if logged_in?
      @user = current_user
      @shows = current_user.shows 
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
    @s = current_user.shows.build(params)
    if @s.save
      redirect "/shows"
    else
      erb :"shows/new"
    end
  end

get '/shows/:id/edit' do
    if logged_in?
      @show = Show.find_by_id(params[:id])
    if @show.user_id == current_user.id
      erb :'shows/edit'
    else
      redirect "/shows"
    end
end
end

  patch '/shows/:id' do
    @show = Show.find_by_id(params[:id])
    @show.update(show_title: params[:show_title])
  if !@show.show_title.empty?
    redirect "/shows/#{@show.id}"
  else
    redirect "/shows/#{@show.id}/edit"
  end
end

get '/shows/:id' do
    @show = Show.find_by(id: params[:id])
    if logged_in?
    erb :"/shows/show"
  else
    redirect "/login"
  end
end 

  delete '/shows/:id/delete' do
    @show = Show.find_by_id(params[:id])
  if logged_in? && @show.user_id == current_user.id
      @show.destroy
      redirect "/shows"
  else
      redirect "/login"
  end
end
end