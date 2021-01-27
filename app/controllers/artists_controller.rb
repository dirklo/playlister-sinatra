class ArtistsController < ApplicationController
    
    get '/artists' do
        @artists = Artist.all
        erb :'/artists/index'    
    end

    get '/artists/:slug' do
        @artist = Artist.find_by_slug(params[:slug])
        erb :'artists/show'
    end

    get '/artists/:slug/edit' do
        @artist = Artist.find_by_slug(params[:slug])
        erb :'artists/edit'
    end

    patch '/artists/:slug' do
        artist = Artist.find_by_slug(params[:slug])
        
        redirect "/artist/#{artist.slug}"
    end

    delete '/artists/:slug' do
        artist = Artist.find_by_slug(params[:slug])
        artist.destroy

        redirect '/artists/'
    end
end
