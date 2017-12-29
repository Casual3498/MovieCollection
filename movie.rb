require './movie.rb'
class Movie
  attr_reader :href, :name, :year, :country, :date, :genres, :duration, :rank, :director, :actors

  def initialize (creator, href:, name:, year:, country:, date:, genres:, duration:, rank:, director:, actors:)
    @creator = creator
    @href = href
    @name = name
    @year = year
    @country = country
    @date = date
    @genres = genres
    @duration = duration
    @rank = rank
    @director = director
    @actors = actors
  end

  def to_s
    "#@name :(#@date ; #@genres) - #@duration country:#@country \n-----------"
  end

  def has_genre?(genre)
    raise "Movie list has no such genre" unless @creator.has_genre?(genre)
    return genres.include?(genre) 
  end

  def duration_sort
    @duration[0..-3].to_i
  end

  def director_sort
    @director.split(' ').last
  end  

  def month
    @date[5..6].to_i 
  end

  def year
    @date[0..3].to_i
  end

  def filtered_by?(field, value)

    value === self.send(field).to_s

  end


end
