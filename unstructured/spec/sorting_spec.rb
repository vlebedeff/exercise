require 'sorting'
require 'benchmark'

module Sorting
  shared_examples 'sorting method' do
    let(:n) { 1000 }
    let(:expectations) do
      {
        [] => [],
        [0] => [0],
        (1..n).to_a => (1..n).to_a,
        n.downto(1).to_a => (1..n).to_a,
        (1..n).to_a.shuffle => (1..n).to_a
      }
    end

    it 'sorts various permutations' do
      expectations.each do |source, result|
        expect(described_class.new(source).sort).to eq(result)
      end
    end
  end

  describe Quick do
    it_behaves_like 'sorting method'

    let!(:ary) { Array.new(100000) { rand(80000) } }
    let(:time) { Benchmark.realtime { described_class.new(ary).sort } }

    [Insertion, Selection, Bubble, Shell].each do |method|
      let(:method_time) { Benchmark.realtime { method.new(ary).sort } } 

      it "is faster than #{method} sort" do
        expect(time).to be < method_time
      end
    end
  end

  describe Insertion do
    it_behaves_like 'sorting method'

    context 'when source array is already sorted' do
      let(:n) { 1000 }
      let(:source) { (1..n).to_a } 
      let(:time) { Benchmark.realtime { described_class.new(source).sort } }
      let(:selection_time) { Benchmark.realtime { Selection.new(source).sort } }
      let(:bubble_time) { Benchmark.realtime { Bubble.new(source).sort } }
      let(:shell_time) { Benchmark.realtime { Shell.new(source).sort } }

      it 'is faster than Selection sort' do
        expect(time).to be < selection_time
      end

      it 'is faster than Bubble sort' do
        expect(time).to be < bubble_time
      end

      it 'is faster than Shell sort' do
        expect(time).to be < shell_time
      end
    end
  end

  describe Shell do
    it_behaves_like 'sorting method'

    context 'when source array is in reverse order' do
      let(:n) { 1000 }
      let(:source) { n.downto(1).to_a }
      let(:time) { Benchmark.realtime { described_class.new(source).sort } }
      let(:insertion_time) { Benchmark.realtime { Insertion.new(source).sort } }
      let(:selection_time) { Benchmark.realtime { Selection.new(source).sort } }
      let(:bubble_time) { Benchmark.realtime { Bubble.new(source).sort } }

      it 'is faster than Insertion sort' do
        expect(time).to be < insertion_time
      end

      it 'is faster than Selection sort' do
        expect(time).to be < selection_time
      end

      it 'is faster than Bubble sort' do
        expect(time).to be < bubble_time
      end
    end
  end

  describe Selection do
    it_behaves_like 'sorting method'
  end

  describe Bubble do
    it_behaves_like 'sorting method'
  end
end
