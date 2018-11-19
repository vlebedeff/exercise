RSpec.describe Exercise::ParallelProcessor do
  let(:examples) do
    {
      [1, Array.new(10) { 1 }] => Array.new(10) { |i| [0, i] },
      [2, Array.new(10) { 1 }] => Array.new(5) { |i| [[0, i], [1, i]] }.reduce(&:concat),
      [3, Array.new(10) { 1 }] => [
        [0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1], [0, 2], [1, 2], [2, 2], [0, 3]
      ],
      [4, Array.new(10) { 1 }] => [
        [0, 0], [1, 0], [2, 0], [3, 0], [0, 1], [1, 1], [2, 1], [3, 1], [0, 2], [1, 2]
      ]
    }
  end

  describe '#run' do
    specify do
      aggregate_failures do
        examples.each do |(worker_count, jobs), result|
          expect(described_class.new(worker_count, jobs).run.map { |w| [w.id, w.available_at] }).to(
            eq(result)
          )
        end
      end
    end
  end
end
