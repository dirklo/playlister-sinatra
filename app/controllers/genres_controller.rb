class GenresController < ApplicationController

    get '/genres' do
        @genres = Genre.all
        erb :'genres/index'
    end

    get '/genres/:slug' do
        @genre = Genre.find_by_slug(params[:slug])
        erb :'genres/show'
    end

    get '/genres/:slug/edit' do
        @genre = Genre.find_by_slug(params[:slug])
        erb :'genres/edit'
    end

    post '/genres/:slug' do
        genre = Genre.find_by_slug(params[:slug])
        
        genre.save
        redirect "/genre/#{genre.slug}"
    end

    delete '/genres/:slug' do
        genre = Genre.find_by_slug(params[:slug])
        genre.destroy
        redirect '/genres'
    end
end