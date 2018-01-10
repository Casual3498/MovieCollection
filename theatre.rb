require './base_cinema.rb'
require 'time'
class Theatre < BaseCinema
  SCHEDULE = { '09:00'..'11:59' => { filters: { period: :ancient, genres: 'Comedy' }, cost: 3 },
               '12:00'..'16:59' => { filters: { genres: %w[Comedy Adventure] }, cost: 5 },
               '17:00'..'23:59' => { filters: { genres: %w[Drama Horror] }, cost: 10 } 
             }

  def show(str_time)
    show_time = Time.strptime(str_time,'%H:%M')
    period, settings = time_period(show_time)
    raise "Theatre is closed now. It will be opened at #{SCHEDULE.first.first.first}." unless period

    films = select_films(settings[:filters])
    film = random_film_by_rank(films)
    showing_film(film, show_time)    
  end


  def when?(film_name) 
    film = @movies.filter(name: film_name).first
    return 'film not found' unless film
    film_time(film) 
  end


  def buy_ticket(str_time)
    show_time = Time.strptime(str_time,'%H:%M')
    period, settings = time_period(show_time)
    raise "You can't to buy ticket on this time. Theatre will be opened #{union_ranges(SCHEDULE.keys)}." unless period

    films = select_films(settings[:filters])
    film = random_film_by_rank(films)    
    puts "You bought ticket on #{film.name}."
    pay(settings[:cost])

  end

  protected


  def film_time(film)
     
    ret = SCHEDULE.select do |key, settings|
      settings[:filters].all? { |key,value| film.filtered_by?(key,value) }
    end.keys

    return 'This movie is not shown in this theatre.' if ret.empty? 
    
    union_ranges(ret)
 
  end

  def time_period(show_time)
    SCHEDULE.find do |key, value| 
      (Time.strptime(key.first,'%H:%M')..Time.strptime(key.last,'%H:%M')).cover?(show_time)
    end
  end

  def union_ranges(range_array)
    range_array.inject do |res,elem| 
      if Time.strptime(res.last,'%H:%M')<(Time.strptime(elem.first,'%H:%M')-60) 
        [res,elem] 
      else 
        (res.first..elem.last) 
      end 
    end 
  end


end