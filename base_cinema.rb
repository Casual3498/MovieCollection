require './movie_collection.rb'
require 'date'

class BaseCinema

  def initialize(filename = 'movies.txt')
    @movies = MovieCollection.new(filename)
  end

  def show(filter_value = {})
    films = select_films(filter_value)
    film = films[rand(films.length)]
    puts "Now showing: #{film} #{Time.now.strftime('%H:%M:%S')} — #{(Time.now + 110*60).strftime('%H:%M:%S')}"
  end

  protected

  def select_films(filter_value)
    @movies.all
  end

end