module Exercise
  RSpec.describe '#range_search' do
    include Exercise

    specify do
      points = [14, 0, 0, 16, 18, 16, 8, 1]
      ranges = [16..22, 12..22]
      expected = [1, 0, 0, 2, 2, 2, 0, 0]
      expect(range_search(points, ranges)).to eq(expected)
    end

    specify do
      points = [11, 14, 5, 4]
      ranges = [6..8, 5..22, 2..2, 2..17, 10..23, 9..15, 7..13, 7..10]
      expected = [5, 4, 2, 1]
      expect(range_search(points, ranges)).to eq(expected)
    end

    specify do
      points = [18, 3, 8, 14, 6, 16, 3]
      ranges = [11..14, 19..25, 5..10, 4..10, 15..32, 18..33, 18..33, 10..13, 12..24]
      expected = [4, 0, 2, 2, 2, 2, 0]
      expect(range_search(points, ranges)).to eq(expected)
    end

    specify do
      points = [8, 9, 7, 2, 4, 11, 3, 3, 0, 0, 19, 2, 4, 18]
      ranges = [4..22, 3..3, 5..6, 18..20, 8..21, 10..16, 13..20, 3..19, 9..10, 7..21, 16..30]
      expected = [4, 5, 3, 0, 2, 5, 2, 2, 0, 0, 7, 0, 2, 7]
      expect(range_search(points, ranges)).to eq(expected)
    end

    specify do
      points = [18, 8, 0, 17]
      ranges = [11..17, 12..19, 8..25, 13..19, 9..27, 2..12]
      expected = [4, 2, 0, 5]
      expect(range_search(points, ranges)).to eq(expected)
    end

    specify do
      100.times do
        points = Array.new(rand(10)) { rand(20) }
        ranges = Array.new(rand(10)) do
          left = rand(20)
          right = rand(20) + left
          Range.new(left, right)
        end
        expected = points.map { |p| ranges.count { |r| r.cover?(p) } }
        actual = range_search(points, ranges)
        expect(actual).to(
          eq(expected),
          <<-MSG
            Points: #{points.inspect}
            Ranges: #{ranges.inspect}
            Expected: #{expected.inspect}
            Actual: #{actual.inspect}
          MSG
        )
      end
    end
  end
end
