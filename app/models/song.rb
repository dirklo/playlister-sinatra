class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def slug
        name.chomp.downcase.split('').reject{|l| l.match(/[^\p{L}\d\s]/u)}.join.gsub(" ", "-")
    end

    def self.find_by_slug(song_slug)
        Song.all.detect {|song| song.slug == song_slug}
    end
end 