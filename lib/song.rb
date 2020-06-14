class Song
    # extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist #invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initialization
        self.genre = genre if genre
        # save

    end

    def self.all
        @@all
    end
    
    def self.destroy_all
        self.all.clear
    end

    def save
        # @@all << self # this worked too
        self.class.all << self
    end

    #initializes, saves, and returns the song
    def self.create(name)
        # self.new(name) # this worked too
        song = new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self) #invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include? self #does not add the song to the genre's collection of songs if it already exists therein
    end

    # finds a song instance in @@all by the name property of the song
    def self.find_by_name(name)
        self.all.detect{|artist| artist.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    #initializes a song based on the passed-in filename
    #invokes the appropriate Findable methods so as to avoid duplicating objects
    def self.new_from_filename(name)
        artist, song, genre_name = name.split(" - ")
        fixed_name = genre_name.gsub(".mp3", "")
        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(fixed_name)
        new(song, artist, genre)
    end

    #initializes and saves a song based on the passed-in filename
    def self.create_from_filename(name)
        new_from_filename(name).save
    end
end