require './movie_collection.rb'

RSpec.describe MovieCollection do
  let(:movie_collection) { MovieCollection.new('movies.txt') }

  describe '#filter' do
  subject(:filter) { movie_collection.filter(filter_value) }

    context "when filter_value is genres: 'Drama' " do
      let(:filter_value) { { genres: 'Drama' } }
      it { expect(filter.sample.genres).to include("Drama") } 
    end

    context "when filter_value is year: 2015 " do
      let(:filter_value) { {  year: 2015 } }
      it { expect(filter.sample.year).to eq(2015) } 
    end

    context "when filter_value is year: 1990..2015 " do
      let(:filter_value) { {  year: 1990..2015 } }
      it { expect(filter.sample.year).to be_between(1990,2015) } 
    end

    context "when filter_value is actors: /C.*Sheen/ " do
      let(:filter_value) { {  actors: /C.*Sheen/ } }
      it { expect(filter.sample.actors).to include(/C.*Sheen/) } 
    end

    context "when filter_value is country: 'USA', genres: 'Comedy', year: 1960..2001, actors: /Hoffma/ " do
      let(:filter_value) { {  country: 'USA', genres: 'Comedy', year: 1960..2001, actors: /Hoffma/ } }
      it { expect(filter.size).to eq(1) } 
    end
    
  end



end