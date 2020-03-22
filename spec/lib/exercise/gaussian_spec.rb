require 'benchmark'

RSpec.describe Exercise, '#gaussian' do
  example do
    expect(
      gaussian_elimination(
        [[1,  3, -4,  8],
         [1,  1, -2,  2],
         [-1, -2,  5, -1]]
      )
    ).to eq([1, 5, 2])
  end

  example do
    expect(
      gaussian_elimination(
        [[2,  1, -1, 8],
         [-3, -1,  2, -11],
         [-2,  1,  2, -3]]
      )
    ).to eq([2, 3, -1])
  end

  example do
    expect(
      gaussian_elimination(
        [[1, 2, 5, 1, 4],
         [3, -4, 3, -2, 7],
         [4, 3, 2, -1, 1],
         [1, -2, -4, -1, 2]]
      )
    ).to eq([3, -2, 0, 5])
  end

  example do
    expect(
      gaussian_elimination(
        [[1, 3, 1, 3, 14],
         [4, -2, -3, 1, 20],
         [2, 1, -1, -1, 9],
         [1, 2, -1, -2, 3]]
      )
    ).to eq([5, 1, 0, 2])
  end

  example do
    expect(
      gaussian_elimination(
        [[1, 3, 1, 3, 14],
         [4, -2, -3, 1, 20],
         [2000, 1000, -1000, -1000, 9000],
         [1, 2, -1, -2, 3]]
      )
    ).to eq([5, 1, 0, 2])
  end

  example do
    expect(
      gaussian_elimination(
        [[0.1, 0.3, 0.11, 0.3, 1.4],
         [4, -2, -3, 1, 20],
         [-2000, -1000, 1000, 1000, -9000],
         [-100_000, -200_000, 100_000, 200_000, -300_000]]
      )
    ).to eq([5, 1, 0, 2])
  end

  specify 'performance' do
    a = [[0.1, 0.3, 0.11, 0.3, 1.4],
         [4, -2, -3, 1, 20],
         [-2000, -1000, 1000, 1000, -9000],
         [-100_000, -200_000, 100_000, 200_000, -300_000]]
    expect(Benchmark.realtime { 1000.times { gaussian_elimination(a) } }).to be < 0.05
  end
end
