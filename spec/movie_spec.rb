require './movie.rb'
require 'date'
RSpec.describe Movie do
  let!(:movie) { Movie.new( nil, href: 'http://www.imdb.com/title/tt0091341/', name: 'Kin-dza-dza!', year: 1986, country: 'Soviet Union', date: '1986-12-01', genres: 'Comedy, Drama, Sci-Fi' , duration: '135 min', rank: '8.2' , director: 'Georgiy Daneliya', actors: ' Stanislav Lyubshin, Evgeniy Leonov, Yuriy Yakovlev ') }
  let!(:movie_collection) { MovieCollection.new('movies.txt') }

  describe '#period' do
 
    it { expect(movie).to respond_to(:period) }

    it 'film types by date' do
      movie_collection.all.each do |movie|
        case movie.year
        when 1900..1945
          expect(movie.period).to eq(:ancient)
        when 1946..1968
          expect(movie.period).to eq(:classic)
        when 1969..2000
          expect(movie.period).to eq(:modern)
        when 2001..Date.today.year
          expect(movie.period).to eq(:new)
        else 
          expect(movie.period).to eq(:out_of_range)
        end
      end
    end

  end

end