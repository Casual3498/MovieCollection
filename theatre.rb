require './base_cinema.rb'
require 'time'
class Theatre < BaseCinema
  SCHEDULE = { morning: '09:00'..'11:59', daytime: '12:00'..'16:59', evening: '17:00'..'23:59', closed: '00:00'..'08:59'}

  def show(str_time)
    show_time = Time.strptime(str_time,'%H:%M')
    
    case time_period(show_time)
    when :morning then filter_values = [{ period: :ancient }]
    when :daytime then filter_values = [{ genres: 'Comedy'}, {genres: 'Adventure'}]
    when :evening then filter_values = [{ genres: 'Drama'}, {genres: 'Horror'}]
    else return "Theatre is closed now. It will be opened at 7:00."
    end

    films = filter_values.map { |filter_value| select_films(filter_value) }.flatten.uniq

    film = random_film_by_rank(films)
    showing_film(film, show_time)    
  end

  def when?(film_name) 
    film = @movies.all.find { |movie| movie.name == film_name }
    return 'film not found' unless film
    film_time(film) 
  end

  protected

  def film_time(film)
    ret = []
    ret << SCHEDULE[:morning] if film.filtered_by?(:period, :ancient)
    ret << SCHEDULE[:daytime] if film.filtered_by?(:genres, 'Comedy') || film.filtered_by?(:genres, 'Adventure')
    ret << SCHEDULE[:evening] if film.filtered_by?(:genres, 'Drama') || film.filtered_by?(:genres, 'Horror')
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
      (Time.strptime(value.first,'%H:%M')..Time.strptime(value.last,'%H:%M')).cover?(show_time)
    end[0]    

  end

end