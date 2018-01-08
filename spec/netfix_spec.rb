require './netflix.rb'

RSpec.describe Netflix do
  let(:netflix) { Netflix.new }

  describe '#money' do
    subject { netflix.money }
    it { is_expected.to eq 0 }
    context 'after paying' do
      before { netflix.pay(25) }
      it { is_expected.to eq 25 }
    end
  end


  describe '#show' do
    subject(:show) { netflix.show(filters) }

    describe 'Netflix can show film with filters' do
      before { netflix.pay(10) }
      context 'when period, director and year film' do
        let(:filters) { { period: :classic, director: 'Akira Kurosawa', year: 1957 } }
        it do
         expect { show }.to output(/\ANow showing:(.*)— классический фильм, режиссёр(.*)\(ещё 5 его фильм\(ов\) в списке\) #{Time.now.strftime('%H:%M')} — #{(Time.now + 110*60).strftime('%H:%M') }/ ).to_stdout
        end
      end
    end

    describe 'charge money' do
      before{ netflix.pay(5.5) }

      context 'when ancient movie' do
        let(:filters) { { period: :ancient } }
        it { expect { show }.to change(netflix, :money).by(-1) }
      end

      context 'when classic movie' do
        let(:filters) { { period: :classic } }
        it { expect { show }.to change(netflix, :money).by(-1.5) }
      end

      context 'when modern movie' do
        let(:filters) { { period: :modern } }
        it { expect { show }.to change(netflix, :money).by(-3) }
      end

      context 'when new movie' do
        let(:filters) { { period: :new } }
        it { expect { show }.to change(netflix, :money).by(-5) }
      end

      # context 'when not enought money' do
      #   let(:filters) { { period: :new } }
      #   it do 
      #     expect { show }.to change(netflix, :money).by(-5)
      #     expect { netflix.show(period: :new) }.to raise_error(RuntimeError, "You have only 0.5 amount of money. The film's cost is 5 money.") 
      #   end
      # end
    end

    describe 'rise exception when not enought money' do
      before { netflix.pay(0.5) }
      let(:filters) { { period: :new } }

      it { expect { netflix.show(period: :new) }.to raise_error(RuntimeError, "You have only 0.5 amount of money. The film's cost is 5 money.") }
    end


  end

  describe '#how_much?' do
    subject(:how_much?) { netflix.how_much?(film_name) }

    context 'when ancient movie' do
      let(:film_name) { 'Modern Times' }  
      it { expect(how_much?).to eq(1) }
    end  

    context 'when classic movie' do
      let(:film_name) { 'Paths of Glory' }  
      it { expect(how_much?).to eq(1.5) }
    end  

    context 'when modern movie' do
      let(:film_name) { 'The Terminator' }  
      it { expect(how_much?).to eq(3) }
    end 

    context 'when new movie' do
      let(:film_name) { 'WALL·E' }  
      it { expect(how_much?).to eq(5) }
    end  

  end 

end