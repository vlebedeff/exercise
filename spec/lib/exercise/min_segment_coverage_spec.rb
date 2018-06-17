module Exercise
  RSpec.describe '#min_segment_coverage' do
    include Exercise

    specify do
      expect(min_segment_coverage([[1, 3], [2, 5], [3, 6]])).to eq([3])
      expect(min_segment_coverage([[4, 7], [1, 3], [2, 5], [5, 6]])).to eq([3, 6])
    end
  end
end
