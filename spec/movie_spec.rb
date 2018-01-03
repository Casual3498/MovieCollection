require './movie.rb'
require 'date'
RSpec.describe Movie do
  let!(:movie) { Movie.new( nil, href: 'http://www.imdb.com/title/tt0091341/', name: 'Kin-dza-dza!', year: 1986, country: 'Soviet Union', date: '1986-12-01', genres: 'Comedy, Drama, Sci-Fi' , duration: '135 min', rank: '8.2' , director: 'Georgiy Daneliya', actors: ' Stanislav Lyubshin, Evgeniy Leonov, Yuriy Yakovlev ') }

  describe '#period' do
 
    it { expect(movie).to respond_to(:period) }

    it 'film types by date' do
      2100.times do |year|
        test_movie = movie.dup 
        test_movie.year = year
        case year
        when 1900..1945
          expect(test_movie.period).to eq(:anchient)
        when 1946..1968
          expect(test_movie.period).to eq(:classic)
        when 1969..2000
          expect(test_movie.period).to eq(:modern)
        when 2001..Date.today.year
          expect(test_movie.period).to eq(:new)
        else 
          expect(test_movie.period).to eq(:out_of_range)
        end
      end
    end

  end

  describe '#to_s' do

    it { expect(movie).to respond_to(:to_s) }

    it 'Anchient movies description' do
      test_movie = movie.dup
      test_movie.year = 1917
      expect(test_movie.to_s).to match "#{test_movie.name} — старый фильм (#{test_movie.year} год)"
    end

    it 'Classic movies description' do
      test_movie = movie.dup
      test_movie.year = 1955
      expect(test_movie.to_s).to match "#{test_movie.name} — классический фильм, режиссёр #{test_movie.director} (ещё -1 его фильм(ов) в списке)"
    end

    it 'Modern movies description' do
      test_movie = movie.dup
      test_movie.year = 1988
      expect(test_movie.to_s).to match "#{test_movie.name} — современное кино, играют #{test_movie.actors.join(',')}"
    end

    it 'New movies description' do
      test_movie = movie.dup
      test_movie.year = 2008
      expect(test_movie.to_s).to match "#{test_movie.name} — новинка, вышло #{Date.today.year-test_movie.year} лет назад!"
    end

  end


end