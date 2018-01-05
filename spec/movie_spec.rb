require './movie.rb'
require 'date'

RSpec.describe Movie do
  let(:movie) { Movie.new( nil, href: 'http://www.imdb.com/title/tt0091341/', name: 'Kin-dza-dza!', year: 1986, country: 'Soviet Union', date: '1986-12-01', genres: 'Comedy, Drama, Sci-Fi' , duration: '135 min', rank: '8.2' , director: 'Georgiy Daneliya', actors: ' Stanislav Lyubshin, Evgeniy Leonov, Yuriy Yakovlev ') }
  let(:movie_collection) { MovieCollection.new('movies.txt') }

  describe '#period' do
    
    it 'ancient film' do
      expect(movie_collection.all.find { |film| (1900..1945).cover?(film.year) }.period).to eq(:ancient)
    end

    it 'classic film' do
      expect(movie_collection.all.find { |film| (1946..1968).cover?(film.year) }.period).to eq(:classic)
    end

    it 'modern film' do
      expect(movie_collection.all.find { |film| (1969..2000).cover?(film.year) }.period).to eq(:modern)
    end

    it 'new film' do
      expect(movie_collection.all.find { |film| (2001..Date.today.year).cover?(film.year) }.period).to eq(:new)
    end    

  end

end