require './base_cinema.rb'
class Netflix < BaseCinema
  attr_reader :money

  FILMS_COSTS = { ancient: 1, classic: 1.5, modern: 3, new: 5 }

  def initialize(filename = 'movies.txt')
    super(filename)
    @money = 0.0
  end

  def pay(amount)
    @money += amount
  end

  def show(filter_value = {})
    films = select_films(filter_value)
    film = random_film_by_rank(films)
    cost = film_cost(film)
    raise "You have only #@money amount of money. The film's cost is #{film_cost(film)} money." if @money < cost
    @money-=cost
    showing_film(film, Time.now) 
  end

  def how_much?(film_name)
    film = @movies.all.find { |movie| movie.name == film_name }
    return 'film not found' unless film
    film_cost(film)
  end  

  protected

  def film_cost(film)
    FILMS_COSTS[:"#{film.period}"]
  end


end
