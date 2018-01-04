require './theatre.rb'

RSpec.describe Theatre do
  let!(:theatre) { Theatre.new }

  describe '#show' do
    it 'Theatre can show film at time' do
      
      #expect { theatre.show('2:00') }.to output.to_stdout 
      expect(theatre.show('2:00')).to eq("Theatre is closed now. It will be opened at 7:00.")
      
      expect { theatre.show('9:00') }.to  output(/\ANow showing:(.*)— старый фильм \((.*) год\)/).to_stdout 

      #expect { theatre.show('14:00') }.to  output(/\ANow showing:(.*)— старый фильм \((.*) год\)/).to_stdout 
    end
  end

  describe "#when?" do

    it { expect(theatre).to respond_to(:when?) }

    it 'Theatre tell when film is started' do
      expect(theatre.when?('The Terminator')).to eq('This movie is not shown in this theatre.')
   
      expect(theatre.when?('Some Like It Hot')).to eq('14:00')

      expect(theatre.when?('Alien')).to eq('18:00')

    end

  end

end