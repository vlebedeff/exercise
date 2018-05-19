RSpec.describe Exercise do
  include Exercise

  describe '#fib_mod_10' do
    it 'calculates N-th Fibbonaci number modulo 10' do
      expect(fib_mod_10(3)).to eq(2)
      expect(fib_mod_10(331)).to eq(9)
      expect(fib_mod_10(327_305)).to eq(5)
    end
  end

  describe '#gcd' do
    it 'calculates greatest common divisor of two numbers' do
      expect(gcd(18, 35)).to eq(1)
      expect(gcd(28_851_538, 1_183_019)).to eq(17_657)
      expect(gcd(1, 2_000_000_000)).to eq(1)
    end
  end
end
