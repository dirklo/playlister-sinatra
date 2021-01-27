class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs

    def slug
        name.chomp.downcase.split('').reject{|l| l.match(/[^\p{L}\d\s]/u)}.join.gsub(" ", "-")
    end

    def self.find_by_slug(artist_slug)
        Artist.all.detect {|artist| artist.slug == artist_slug}
    end
end