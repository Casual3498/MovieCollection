require './movie_collection.rb'
require 'time'

class BaseCinema

  def initialize(filename = 'movies.txt')
    @movies = MovieCollection.new(filename)
  end

  def show(filter_value = {})
    raise NotImplementedError, 'BaseCinema#show not implemented'
    # films = select_films(filter_value)
    # film = random_film_by_rank(films)
    # showing_film(film, Time.now)
  end

  protected

  def select_films(filter_value)
    @movies.filter(filter_value)
  end

  def showing_film(film, time_begin)
    puts "Now showing: #{film} #{time_begin.strftime('%H:%M')} — #{(time_begin + 110*60).strftime('%H:%M')}"
  end

  def random_film_by_rank(films)
    films.map do |film|
      if film.rank <= 8.1 
        film
      else
        Array(film)*((film.rank-8)*10)
      end
    end.flatten.sample
  end

end