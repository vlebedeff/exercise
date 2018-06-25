module Exercise
  RSpec.describe '#max_salary' do
    include Exercise

    def max_salary_naive(numbers)
      numbers.permutation.to_a.map { |perm| perm.join.to_i }.max
    end

    specify do
      expect(max_salary([21, 2])).to eq(221)
      expect(max_salary([2, 21])).to eq(221)
      expect(max_salary([9, 4, 6, 9, 1])).to eq(99_641)
      expect(max_salary([23, 39, 92])).to eq(923_923)
      expect(max_salary([8])).to eq(8)
      expect(max_salary([33])).to eq(33)
      expect(max_salary([353, 392, 33, 286, 28, 581])).to eq(5_813_923_533_328_628)
    end
  end
end
