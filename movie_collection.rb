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
      @films_array.sort_by { |film| film.duration[0..-3].to_f }
    when :director 
      @films_array.sort_by { |film| film.director.split(' ').last }
    else
      @@keys_array.include?(field_name) ? @films_array.sort_by(&field_name) : "Unknown field name #{field_name}, use #{@@keys_array}"
    end
  end

  def filter(field_value = {})
    ret = []
    field_value.each do |key, value|
      ret << @films_array.select { |film| film.send(key).include?(value) }
    end
    return ret
  end

  def stats(field_name)
    stat_hash = {}
    case field_name
    when :director
      stat_hash = @films_array.group_by(&:director).map { |director, director_films| [director, director_films.count] }.to_h
    when :month
      stat_hash = @films_array.group_by { |film| film.date[5..6].to_i }.map { |month, months_films| [month, months_films.count] }.to_h
    when :year
      stat_hash = @films_array.group_by { |film| film.date[0..3].to_i }.map { |year, year_films| [year, year_films.count] }.to_h
    when :actor then
      stat_hash = @films_array.each_with_object(Hash.new(0)) { |str, hsh| str.send(:actors).split(',').each { |actor| hsh[actor] += 1 } }
    when :country
      stat_hash = @films_array.each_with_object(Hash.new(0)) { |str, hsh| str.send(:country).split(',').each do |country| hsh[country] += 1 end }
    when :genre
      stat_hash =  @films_array.each_with_object(Hash.new(0)) { |str, hsh| str.send(:genres).split(',').each do |genre| hsh[genre] += 1 end }
    else 
      { error: "Unknown field name #{field_name}, use :director, :actor, :year, :month, :country, :genre" }
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



