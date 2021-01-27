class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def slug
        name.chomp.downcase.split('').reject{|l| l.match(/[^\p{L}\d\s]/u)}.join.gsub(" ", "-")
    end

    def self.find_by_slug(genre_slug)
        Genre.all.detect {|genre| genre.slug == genre_slug}
    end
end