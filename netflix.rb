require './base_cinema.rb'

class Netflix < BaseCinema

  #attr_reader :money

  FILMS_COSTS = { ancient: 1, classic: 1.5, modern: 3, new: 5 }
  @@money = 0.0

  def pay(amount)
    @@money += amount
  end

  def self.cash
    @@money
  end

  def cash
    raise NotImplementedError, 'Netflix#cash not implemented'
  end

  def self.take(who)
    raise 'Error! Call the police!' unless who == 'Bank'
    puts 'Encashment'
    @@money = 0.0
  end

  def take(who)
    raise NotImplementedError, 'Netflix#take not implemented'
  end

  def show(filter_value = {})
    films = select_films(filter_value)
    film = random_film_by_rank(films)
    cost = film_cost(film)
    raise "You have only #{Netflix.cash} amount of money. The film's cost is #{film_cost(film)} money." if Netflix.cash < cost
    @@money-=cost
    showing_film(film, Time.now) 
  end

  def how_much?(film_name)
    film = @movies.all.find { |movie| movie.name == film_name }
    return 'film not found' unless film
    film_cost(film)
  end  


  protected

  def film_cost(film)
    FILMS_COSTS[film.period]
  end


end
