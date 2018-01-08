require './base_cinema.rb'
require 'time'
class Theatre < BaseCinema
  SCHEDULE = { morning: '09:00'..'11:59', daytime: '12:00'..'16:59', evening: '17:00'..'23:59', closed: '00:00'..'08:59'}
  SCHEDULE_FILTERS = { morning:  [{ period: :ancient }], daytime:  [{ genres: 'Comedy'}, {genres: 'Adventure'}], evening: [{ genres: 'Drama'}, {genres: 'Horror'}], closed: "Theatre is closed now. It will be opened at #{SCHEDULE[:morning].first}." }

  def show(str_time)
    show_time = Time.strptime(str_time,'%H:%M')
    

    day_period = time_period(show_time)
    return SCHEDULE_FILTERS[day_period] if day_period == :closed

    filter_values = SCHEDULE_FILTERS[day_period]

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
     
    ret =[:morning, :daytime, :evening].map do |day_period| 
      SCHEDULE[day_period] if film_filtered_by_single_filters?(film, SCHEDULE_FILTERS[day_period])
    end.compact
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

  def film_filtered_by_single_filters?(film, filters_array)
    filters_array.find { |filter| film.filtered_by?(filter.first[0], filter.first[1]) }
  end

end