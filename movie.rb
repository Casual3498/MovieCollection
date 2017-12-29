require './movie.rb'
class Movie
  attr_reader :href, :name, :year, :country, :date, :genres, :duration, :rank, :director, :actors

  def initialize (creator, href:, name:, year:, country:, date:, genres:, duration:, rank:, director:, actors:)
    @creator = creator
    @href = href
    @name = name
    @year = year
    @country = country.split(',')
    @date = date
    @genres = genres.split(',')
    @duration = duration.split(" ")[0].to_i
    # @duration_unit = :"#{duration.split(" ")[1]}"
    @rank = rank
    @director = director
    @actors = actors.split(',')
    # raise "Duration time unit #@duration_unit is uncorrect" unless @duration_unit == :min
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

  def year
    @date[0..3].to_i
  end

  def filtered_by?(field, value)
    
    Array(self.send(field)).grep(value).any?

  end


end
