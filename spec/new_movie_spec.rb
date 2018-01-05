require './new_movie.rb'
require 'date'

RSpec.describe NewMovie do
  let(:movie) { NewMovie.new( nil, href: 'http://www.imdb.com/title/tt0091341/', name: 'Kin-dza-dza!', year: 2008, country: 'Soviet Union', date: '1986-12-01', genres: 'Comedy, Drama, Sci-Fi' , duration: '135 min', rank: '8.2' , director: 'Georgiy Daneliya', actors: ' Stanislav Lyubshin, Evgeniy Leonov, Yuriy Yakovlev ') }

  describe '#to_s' do

    it 'New movies description' do
      expect(movie.to_s).to match "#{movie.name} — новинка, вышло #{Date.today.year-movie.year} лет назад!"
    end

  end
  
end