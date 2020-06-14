class Artist
    extend Concerns::Findable
    attr_accessor :name

    # returns the artist's 'songs' collection (artist has many songs)
    attr_reader :songs 

    @@all = []

    def initialize(name)
        @name = name
        @songs = [] #creates a 'songs' property set to an empty array (artist has many songs)
        # save
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        # @@all << self  #this works too
        self.class.all << self
    end

    # initializes and saves the artist
    def self.create(name)
        # self.new(name)
        artist = new(name)
        artist.save
        artist
    end

    # def songs
    #     @songs
    # end

    def add_song(song)
        song.artist = self unless song.artist 
        @songs << song unless @songs.include?(song)
    end

    # returns a collection of genres for all of the artist's songs (artist has many genres through songs)
    # does not return duplicate genres if the artist has more than one song of a particular genre (artist has many genres through songs)
    # collects genres through its songs instead of maintaining its own @genres instance variable (artist has many genres through songs)
    def genres
        songs.collect(&:genre).uniq
    end
end