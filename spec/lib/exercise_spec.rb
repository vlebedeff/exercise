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
      expect(gcd(2_000_000_000, 1_999_999_998)).to eq(2)
    end
  end

  describe '#lcm' do
    it 'calculates least common multiple of two numbers' do
      expect(lcm(6, 8)).to eq(24)
      expect(lcm(28_851_538, 1_183_019)). to eq(1_933_053_046)
      expect(lcm(2_000_000_000, 1_999_999_998)).to eq(1_999_999_998_000_000_000)
    end
  end
end
