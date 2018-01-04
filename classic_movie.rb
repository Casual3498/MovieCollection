require './movie.rb'

class ClassicMovie < Movie

  def to_s
    "#@name — классический фильм, режиссёр #@director (ещё #{self.director_films_count(@director)-1} его фильм(ов) в списке)"
  end

end