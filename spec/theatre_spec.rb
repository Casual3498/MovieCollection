require './theatre.rb'

RSpec.describe Theatre do

  describe '#show' do
    it 'Theatre can show film at time' do
      theatre = Theatre.new
      
      expect { theatre.show }.to output.to_stdout 
      #expect { theatre.show('9:00') }.to output(/Theatre#show/).to_stdout

    end
  end

end