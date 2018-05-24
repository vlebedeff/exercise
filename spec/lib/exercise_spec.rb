RSpec.describe Exercise do # rubocop:disable Metrics/BlockLength
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

  describe '#pisano_period' do
    specify do
      [[2, 3], [3, 8], [4, 6], [5, 20], [6, 24], [7, 16], [144, 24]].each do |m, expected|
        expect(pisano_period(m)).to eq(expected), "Pisano Period of #{m} is #{expected}"
      end
    end
  end

  describe '#fib_mod_m' do
    specify do
      expect(fib_mod_m(239, 1_000)).to eq(161)
      expect(fib_mod_m(2_816_213_588, 239)).to eq(151)
    end
  end

  describe '#fib_sum_mod_10' do
    specify do
      expect(fib_sum_mod_10(3)).to eq(4)
      expect(fib_sum_mod_10(100)).to eq(5)
      expect(fib_sum_mod_10(240)).to eq(0)
    end
  end

  describe '#fib_sum_partial_mod_10' do
    specify do
      expect(fib_sum_partial_mod_10(3, 7)).to eq(1)
      expect(fib_sum_partial_mod_10(10, 10)).to eq(5)
      expect(fib_sum_partial_mod_10(10, 200)).to eq(2)
      expect(fib_sum_partial_mod_10(1234, 12_345)).to eq(8)
    end
  end
end
