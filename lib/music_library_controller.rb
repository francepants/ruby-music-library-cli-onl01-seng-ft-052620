class MusicLibraryController
    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        input = ""
        while input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"

            input = gets.strip

            case input
                when "list songs"
                list_songs
                when "list artists"
                list_artists
                when "list genres"
                list_genres
                when "list artist"
                list_songs_by_artist
                when "list genre"
                list_songs_by_genre
                when "play song"
                play_song
            
            end
        end
        
    end

    #prints all songs in the music library in a numbered list (alphabetized by song name)
    def list_songs
        Song.all.sort_by(&:name).each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    #prints all artists in the music library in a numbered list (alphabetized by artist name)
    def list_artists
        Artist.all.sort_by(&:name).each.with_index(1) do |artist, index|
            puts "#{index}. #{artist.name}"
        end
    end
    
    #prints all genres in the music library in a numbered list 
    def list_genres
        Genre.all.sort_by(&:name).each.with_index(1) do |gen, index|
            puts "#{index}. #{gen.name}"
        end
    end

    #accepts user input
    #prints all songs by a particular artist in a numbered list (alphabetized by song name)
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip

        if artist = Artist.find_by_name(input)
            artist.songs.sort_by(&:name).each.with_index(1) do |song, index|
                puts "#{index}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    #prompts the user to enter a genre
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            genre.songs.sort_by(&:name).each.with_index(1) do |song, index|
                puts "#{index}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    #accepts user input
    #upon receiving valid input 'plays' the matching song from the alphabetized list output by #list_songs
    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        if (1..Song.all.length).include?(input)
            song = Song.all.sort_by(&:name)[input - 1]
        end
        puts "Playing #{song.name} by #{song.artist.name}" if song
    end
end