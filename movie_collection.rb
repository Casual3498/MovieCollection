require 'csv'
require './movie.rb'


class MovieCollection

  def to_s
    @films_array.join("\n")
  end

  def all
    @films_array
  end

  def sort_by(field_name)  
    case field_name
    when :duration
      @films_array.sort_by(&:duration_sort)
    when :director 
      @films_array.sort_by(&:director_sort)
    else
      @@keys_array.include?(field_name) ? @films_array.sort_by(&field_name) : "Unknown field name #{field_name}, use #{@@keys_array}"
    end
  end

  def filter(field_value )

    @films_array.select { |movie| field_value.all? { |key, value| movie.filtered_by?(key, value) } } 

  end

  def stats(field_name)
    stat_hash = {}
    case field_name
    when :director, :month, :year
      stat_hash = @films_array.group_by(&field_name).map { |field, field_films| [field, field_films.count] }.to_h
    when :actors, :country, :genres 
      stat_hash = @films_array.each_with_object(Hash.new(0)) { |str, hsh| str.send(field_name).split(',').each { |field| hsh[field] += 1 } }
    else 
      { error: "Unknown field name #{field_name}, use :director, :actors, :year, :month, :country, :genres" }
    end
  end

  def has_genre?(genre)
    @films_array.each do |film|
      return true if film.genres.include?(genre)
    end
    return false
  end

  private
  @@keys_array = %i[href name year country date genres duration rank director actors]
  @films_array = []  
  def initialize (filename = 'movies.txt')
    @films_array = CSV.read(filename, col_sep: '|', headers: @@keys_array).map { |string| Movie.new(self, string.to_h) }    
  end


end



