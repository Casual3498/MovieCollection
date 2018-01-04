require './movie.rb'

class NewMovie < Movie

  def to_s
    "#@name — новинка, вышло #{Date.today.year-@year} лет назад!"
  end

end