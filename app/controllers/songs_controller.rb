class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        erb :'/songs/new'
      end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end
    
    post '/songs' do
        song = Song.new(name: params[:song][:name])
        if params[:genres]
            params[:genres].each do |genre_id|
                song.genres << Genre.find(genre_id)
            end
        end
        if params[:artist][:name] && !Artist.find_by(name: params[:artist][:name])
            artist = Artist.create(name: params[:artist][:name])
            song.artist = artist
        else
            artist = Artist.find_by(name: params[:artist][:name])
            song.artist = artist
        end 
        song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{song.slug}"
    end

    patch '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])
        if params[:genres]
            params[:genres].each do |genre_id|
                genre = Genre.find(genre_id)
                song.genres << genre unless song.genres.include?(genre)
            end
        end
        if params[:artist][:name] && !Artist.find_by(name: params[:artist][:name])
            artist = Artist.create(name: params[:artist][:name])
            song.artist = artist
        else
            artist = Artist.find_by(name: params[:artist][:name])
            song.artist = artist
        end 
        song.save
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{song.slug}"
    end
    
    delete '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])
        song.destroy
        redirect '/songs'
    end
end 