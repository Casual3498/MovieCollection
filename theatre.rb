require './base_cinema.rb'
require 'time'
class Theatre < BaseCinema
  SCHEDULE = { '09:00'..'11:59' => { period: :ancient, genres: 'Comedy' },
               '12:00'..'16:59' => { genres: %w[Comedy Adventure] },
               '17:00'..'23:59' => { genres: %w[Drama Horror] } 
             }

  def show(str_time)
    show_time = Time.strptime(str_time,'%H:%M')
    period, filters = time_period(show_time)
    raise "Theatre is closed now. It will be opened at #{SCHEDULE.first.first.first}." unless period

    films = select_films(filters)
    film = random_film_by_rank(films)
    showing_film(film, show_time)    
  end


  def when?(film_name) 
    film = @movies.filter(name: film_name).first
    return 'film not found' unless film
    film_time(film) 
  end


  protected


  def film_time(film)
     
    ret = SCHEDULE.select do |key, field_value|
      field_value.all? { |key,value| film.filtered_by?(key,value) }
    end.keys

    return 'This movie is not shown in this theatre.' if ret.empty? 
    
    #union ranges
    ret.inject do |res,elem| 
      if Time.strptime(res.last,'%H:%M')<(Time.strptime(elem.first,'%H:%M')-60) 
        [res,elem] 
      else 
        (res.first..elem.last) 
      end 
    end  
  end

  def time_period(show_time)
    SCHEDULE.find do |key, value| 
      (Time.strptime(key.first,'%H:%M')..Time.strptime(key.last,'%H:%M')).cover?(show_time)
    end
  end


end