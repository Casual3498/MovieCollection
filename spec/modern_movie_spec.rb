require './modern_movie.rb'

RSpec.describe ModernMovie do
  let!(:movie) { ModernMovie.new( nil, href: 'http://www.imdb.com/title/tt0091341/', name: 'Kin-dza-dza!', year: 1986, country: 'Soviet Union', date: '1986-12-01', genres: 'Comedy, Drama, Sci-Fi' , duration: '135 min', rank: '8.2' , director: 'Georgiy Daneliya', actors: ' Stanislav Lyubshin, Evgeniy Leonov, Yuriy Yakovlev ') }

  describe '#to_s' do

    it { expect(movie).to respond_to(:to_s) }

    it 'Modern movies description' do
      expect(movie.to_s).to match "#{movie.name} — современное кино, играют #{movie.actors.join(',')}"
    end

  end
end