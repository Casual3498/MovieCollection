require './base_cinema.rb'
require 'time'
class Theatre < BaseCinema

  def show(time)
    show_time = Time.strptime(time,'%H:%M')
    return "Theatre is closed now. It will be opened at 7:00." if show_time >= Time.strptime('0:00','%H:%M') && show_time < Time.strptime('7:00','%H:%M')

    case 
    when show_time >= Time.strptime('7:00','%H:%M') && show_time < Time.strptime('12:00','%H:%M')
      filter_values = [{ period: :ancient }]
    when show_time >= Time.strptime('12:00','%H:%M') && show_time < Time.strptime('17:00','%H:%M')
      filter_values = [{ genres: 'Comedy'}, {genres: 'Adventure'}]
    when show_time >= Time.strptime('17:00','%H:%M') && show_time <= Time.strptime('23:59','%H:%M')
      filter_values = [{ genres: 'Drama'}, {genres: 'Horror'}]
    end 
    films = []
    filter_values.each do |filter_value|
      films += select_films(filter_value)
    end
    films.uniq!

    film = random_film_by_rank(films)
    showing_film(film, show_time)    
  end

  def when?(film_name) 
    film = @movies.all.find { |movie| movie.name == film_name }
    return 'film not found' unless film
    film_time(film).join(',')
 
  end

  protected

  def film_time(film)
    ret = []
    ret << '9:00'  if film.filtered_by?(:period, :ancient)
    ret << '14:00' if film.filtered_by?(:genres, 'Comedy') || film.filtered_by?(:genres, 'Adventure')
    ret << '18:00' if film.filtered_by?(:genres, 'Drama, Horror') || film.filtered_by?(:genres, 'Horror')
    ret << 'This movie is not shown in this theatre.' if ret.empty? 
    return ret     
  end

end