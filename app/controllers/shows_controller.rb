class ShowsController < ApplicationController
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