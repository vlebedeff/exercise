RSpec.describe Exercise do
  include Exercise

  describe '#fib_mod_10' do
    it 'calculates N-th Fibbonaci number modulo 10' do
      expect(fib_mod_10(3)).to eq(2)
      expect(fib_mod_10(331)).to eq(9)
      expect(fib_mod_10(327_305)).to eq(5)
    end
  end
end
