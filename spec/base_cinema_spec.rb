require './base_cinema.rb'

RSpec.describe BaseCinema do
  let(:cinema) { BaseCinema.new }

  describe '#show' do    
    it 'BaseCinema can output "Now showing:"' do        
      expect { cinema.show }.to  raise_error(NotImplementedError,'BaseCinema#show not implemented')
    end
  end

  describe '#cash' do
    subject { cinema.cash }
    it { is_expected.to eq 0 }
    context 'after paying' do
      before { cinema.pay(25) }
      it { is_expected.to eq 25 }
    end
  end

  describe '#take' do
    subject(:take) { cinema.take(who) }
    
    context 'Bank can encashment' do
      let(:who) { 'Bank' }
      it { expect { take }.to output(/Encashment/).to_stdout }
    end

    context 'Bank can encashment' do
      let(:who) { 'Thief' }
      it { expect { take }.to raise_error(RuntimeError, "Error! Call the police!") } 
    end    

  end

end