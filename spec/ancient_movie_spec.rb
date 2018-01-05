require './ancient_movie.rb'

RSpec.describe AncientMovie do
  let(:movie) { AncientMovie.new( nil, href: 'http://www.imdb.com/title/tt0091341/', name: 'Kin-dza-dza!', year: 1917, country: 'Soviet Union', date: '1986-12-01', genres: 'Comedy, Drama, Sci-Fi' , duration: '135 min', rank: '8.2' , director: 'Georgiy Daneliya', actors: ' Stanislav Lyubshin, Evgeniy Leonov, Yuriy Yakovlev ') }

  describe '#to_s' do

    it 'Ancient movies description' do
      expect(movie.to_s).to match "#{movie.name} — старый фильм (#{movie.year} год)"
    end

  end

end