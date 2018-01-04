require './netflix.rb'
# require 'pp'

RSpec.describe Netflix do
  let!(:netflix) { Netflix.new }


  describe '#pay' do
    it { expect(netflix).to respond_to(:pay) }

    it 'Netflix can receive payments' do
      expect { netflix.pay(25) }.to change(netflix, :money).by(25)

    end

  end


  describe '#show' do

    it { expect(netflix).to respond_to(:show) }
    
    it 'Netflix can show film with filters' do
      netflix.pay(10) # for prevent exception
      
      expect { netflix.show }.to output.to_stdout 

      expect { netflix.show(period: :classic, director: 'Akira Kurosawa', year: 1957) }.to  output(/\ANow showing:(.*)— классический фильм, режиссёр(.*)\(ещё 5 его фильм\(ов\) в списке\) #{Time.now.strftime('%H:%M')} — #{(Time.now + 110*60).strftime('%H:%M') }/ ).to_stdout
    end

    it 'Netflix charge money' do
      netflix.pay(11)
      expect { netflix.show(period: :ancient) }.to change(netflix, :money).by(-1)
      expect { netflix.show(period: :classic) }.to change(netflix, :money).by(-1.5)
      expect { netflix.show(period: :modern) }.to change(netflix, :money).by(-3)
      expect { netflix.show(period: :new) }.to change(netflix, :money).by(-5)
      # now we have only 0.5 money
      expect { netflix.show(period: :new) }.to raise_error(RuntimeError, "You have only 0.5 amount of money. The film's cost is 5 money.")
    end

  end

  describe '#how_much?' do

     it { expect(netflix).to respond_to(:how_much?) }

     it { expect(netflix.how_much?('The Terminator')).to eq(3) } # modern movie

  end 




end