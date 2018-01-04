require './movie.rb'
require 'date'
class Movie
  attr_accessor :href, :name, :year, :country, :date, :genres, :duration, :rank, :director, :actors
  
  def initialize (creator, href:, name:, year:, country:, date:, genres:, duration:, rank:, director:, actors:)
    @creator = creator
    @href = href
    @name = name
    @year = year.to_i
    @country = country.split(',')
    @date = date
    @genres = genres.split(',')
    @duration = duration.split(" ")[0].to_i
    @rank = rank.to_f
    @director = director
    @actors = actors.split(',')
  end

  def to_s
    "#@name :(#@date ; #{@genres.join(',')}) - #@duration min country:#{@country.join(',')} \n-----------"
  end

  def has_genre?(genre)
    raise "Movie list has no such genre" unless @creator.has_genre?(genre)
    return genres.include?(genre) 
  end

  def director_last_name
    @director.split(' ').last
  end  

  def month
    @date[5..6].to_i 
  end

  def filtered_by?(field, value)
    Array(self.send(field)).grep(value).any?
  end

  def period     
    case self
    when AncientMovie  then :ancient
    when ClassicMovie  then :classic
    when ModernMovie   then :modern
    when NewMovie      then :new
    else :out_of_range
    end
  end

  def director_films_count(director)
    return 0 unless @creator
    @creator.stats('director')[director]
  end


end
