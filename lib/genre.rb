class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        # save
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        # @@all << self
        self.class.all << self
    end

    def self.create(name)
        # self.new(name)
        genre = new(name)
        genre.save
        genre
    end

    def artists
        songs.collect(&:artist).uniq
    end
end