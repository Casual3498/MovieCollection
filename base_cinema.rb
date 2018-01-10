require_relative 'movie_collection'
require_relative 'cashbox'
require 'time'

class BaseCinema
  include Cashbox 

  def initialize(filename = 'movies.txt')
    @movies = MovieCollection.new(filename)
    @money = 0.0
  end

  def take(who)
    raise 'Error! Call the police!' unless who == 'Bank'
    puts 'Encashment'
    @money = 0.0
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
    films.sort_by { |film| rand * film.rank }.last
  end

end