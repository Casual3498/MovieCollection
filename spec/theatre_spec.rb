require './theatre.rb'

RSpec.describe Theatre do
  let(:theatre) { Theatre.new }

  describe '#show' do
    subject(:show) { theatre.show(time) }

    describe 'is closed at night' do
      let(:time) { '2:00' }
      it { expect { show }.to raise_error(RuntimeError, "Theatre is closed now. It will be opened at 09:00.") }
    end

    describe 'anchient films at morning' do
      let(:time) { '9:00' }
      it { expect { show }.to output(/\ANow showing:(.*)— старый фильм \((.*) год\)/).to_stdout }
    end 

  end

  describe "#when?" do
    subject(:when?) { theatre.when?(film_name) }

    describe 'only anchient films or comedy, adventure, drama and horror' do
      let(:film_name) { 'The Terminator' }
      it { expect(when?).to eq('This movie is not shown in this theatre.') }  
    end

    describe 'comedy will be shown in daytime (12:00 - 16:59)' do
      let(:film_name) { 'Some Like It Hot' }
      it { expect(when?).to eq('12:00'..'16:59') }  
    end

    describe 'horror will be shown in evening (17:00 - 23:59)' do
      let(:film_name) { 'Alien' }
      it { expect(when?).to eq('17:00'..'23:59') }  
    end

    describe 'anchient comedy and drama will be shown all day' do
      let(:film_name) { 'Modern Times' }
      it { expect(when?).to eq('09:00'..'23:59') }  
    end

  end



  describe 'filters at :morning' do
    it do
      expect(theatre).to receive(:select_films).with(period: :ancient, genres: 'Comedy').and_call_original
      theatre.show('09:00')
    end
  end

  describe 'filters at :daytime' do
    it do
      expect(theatre).to receive(:select_films).with(genres: contain_exactly('Adventure', 'Comedy')).and_call_original
      theatre.show('14:00')
    end
  end

  describe 'filters at :evening' do
    it do
      allow(theatre).to receive(:select_films).with(genres: match_array(%w[Drama Horror]) ).and_call_original
      theatre.show('19:00')
      expect(theatre).to have_received(:select_films).with(genres: match_array(%w[Drama Horror]) )
    end
  end


end
