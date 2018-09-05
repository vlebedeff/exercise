module Exercise
  RSpec.describe ClosestPointFinder do
    describe '#distance' do
      let(:expectations) do
        {
          [[5, 5], [1, 2], [10, 7], [1, 0], [5, 5]] => 0,
          [[1, 1], [1, 2], [3, 7], [100, 10], [42, 42]] => 1,
          [
            [4, 4], [-2, -2], [-3, -4], [-1, 3], [2, 3], [-4, 0],
            [1, 1], [-1, -1], [3, -1], [-4, 2], [-2, 4]
          ] => Math.sqrt(2)
        }
      end

      specify do
        expectations.each do |points, min_distance|
          expect(
            described_class.new(points.map { |x, y| Point.new(x, y) }).distance
          ).to eq(min_distance)
        end
      end
    end
  end
end
