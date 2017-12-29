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
    when :director 
      @films_array.sort_by(&:director_last_name)
    else
      @@keys_array.include?(field_name) ? @films_array.sort_by(&field_name) : "Unknown field name #{field_name}, use #{@@keys_array}"
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

  private

  @@keys_array = %i[href name year country date genres duration rank director actors]
  @films_array = [] 
  @genres = []

  def initialize (filename = 'movies.txt')
    @films_array = CSV.read(filename, col_sep: '|', headers: @@keys_array).map do |string| 
      @genres = Array(@genres) + Array(string.to_h[:genres])       # cache genres
      Movie.new(self, string.to_h) 
    end
  end


end
