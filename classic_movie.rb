require './movie.rb'

class ClassicMovie < Movie

  def to_s
    "#@name — классический фильм, режиссёр #@director (ещё #{self.director_films_count(@director)-1} его фильм(ов) в списке)"
  end

  def director_films_count(director)
    return 0 unless @creator
    @creator.stats('director')[director]
  end

end