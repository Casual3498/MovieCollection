require './base_cinema.rb'
class Netflix < BaseCinema
  attr_reader :money
  def initialize(filename = 'movies.txt')
    @money = 0.0
    super
  end

  def pay(amount)
    @money += amount
  end

  def show(filter_value = {})
    films = select_films(filter_value)
    film = films[rand(films.length)]
    cost = film_cost(film)
    raise "Not enough money to show film!" if @money < cost

    @money-=cost

    puts "Now showing: #{film} #{Time.now.strftime('%H:%M:%S')} — #{(Time.now + 110*60).strftime('%H:%M:%S')}"
  end

  def how_much?(film_name)
    film = @movies.all.select { |movie| movie.name == film_name }
    if film.length == 1
      film_cost(film[0])
    else
      'film not found or found more than 1'
    end
    
  end  

  protected

  def select_films(filter_value)
    @movies.filter(filter_value)
  end

  def film_cost(film)
    case film.period
    when :anchient then 1
    when :classic then 1.5
    when :modern then 3
    when :new then 5
    else 10**10 end
  end


end

      # netflix = Netflix.new
      
      
      # puts netflix.show(genres: 'Comedy', period: :modern)