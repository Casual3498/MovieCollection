require './movie.rb'
class Movie
  attr_accessor :href, :name, :year, :country, :date, :genres, :duration, :rank, :director, :actors

  def initialize (creator = MovieCollection.new, params = {})
    @creator = creator
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def to_s
    "#@name :(#@date ; #@genres) - #@duration country:#@country \n-----------"
  end

  def has_genre?(genre)
    if @creator.has_genre?(genre)
      genres.include?(genre) ? true : false
    else # raise error
      raise "Movie list has no such genre"
    end
  end


end