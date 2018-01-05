require './base_cinema.rb'

RSpec.describe BaseCinema do
  let(:cinema) { BaseCinema.new }

  describe '#show' do
    
    it 'BaseCinema can output "Now showing:"' do        
      expect { cinema.show }.to  raise_error(NotImplementedError,'BaseCinema#show not implemented')
    end

  end

end