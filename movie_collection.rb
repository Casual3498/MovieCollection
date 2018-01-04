require 'csv'

require './ancient_movie.rb'
require './classic_movie.rb'
require './modern_movie.rb'
require './new_movie.rb'

class MovieCollection

  KEYS_ARRAY = %i[href name year country date genres duration rank director actors]

  def initialize (filename = 'movies.txt')
    @films_array = CSV.read(filename, col_sep: '|', headers: KEYS_ARRAY).map do |string| 
      case (string.to_h[:year].to_i)
      when 1900..1945 then AncientMovie.new(self, string.to_h)
      when 1946..1968 then ClassicMovie.new(self, string.to_h)
      when 1969..2000 then ModernMovie.new(self, string.to_h)
      when 2001..Date.today.year then NewMovie.new(self, string.to_h)
      else Movie.new(self, string.to_h) 
      end
    end
    @genres = @films_array.map(&:genres).flatten.uniq
  end

  def to_s
    @films_array.join("\n")
  end

  def all
    @films_array
  end

  def sort_by(field_name)  
    return "Unknown field name #{field_name}, use #{KEYS_ARRAY}" unless KEYS_ARRAY.include?(field_name)
    case field_name
    when :director 
      @films_array.sort_by(&:director_last_name)
    else
      @films_array.sort_by(&field_name)
    end
  end

  def filter(field_value )
    @films_array.select { |movie| field_value.all? { |key, value| movie.filtered_by?(key, value) } } 
  end

  def stats(field_name)
    @films_array.each_with_object(Hash.new(0)) { |str, hsh| Array(str.send(field_name)).each { |field| hsh[field] += 1 } }
  end

  def has_genre?(genre)
    @genres.include?(genre)
  end


end
