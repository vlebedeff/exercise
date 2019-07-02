RSpec.describe Exercise::SplaySet do
  shared_examples 'splay tree set' do |size, order|
    context 'when values are inserted in ascending order' do
      let(:values) do
        initial = Array.new(size) { |i| i }
        case order
        when :asc then initial
        when :desc then initial.reverse
        else initial.shuffle
        end
      end
      let(:baseline_set) { Set.new(values) }

      subject(:splay_set) do
        values.reduce(described_class.new) do |set, value|
          set.insert(value)
        end
      end

      describe '#find' do
        specify do
          values_found = values.map { |v| splay_set.find(v).node.value }
          expect(values_found).to eq(values)
        end
      end

      describe '#delete' do
        let(:deleted_element) { values.sample }
        let(:splay_subset) { splay_set.delete(deleted_element) }

        specify do
          values_found = values.select { |v| splay_subset.find(v).node.value == v }
          expect(values_found).to eq(values.reject { |x| x == deleted_element })
        end
      end

      describe '#sum' do
        let(:baseline_sum) { baseline_set.reduce(0) { |sum, v| bounds.cover?(v) ? sum + v : sum } }

        context 'first two values' do
          let(:bounds) { Range.new(*values.sort.first(2)) }

          specify do
            expect(splay_set.sum(bounds)).to eq(baseline_sum)
          end
        end

        context 'last two values' do
          let(:bounds) { Range.new(*values.sort.last(2)) }

          specify do
            expect(splay_set.sum(bounds)).to eq(baseline_sum)
          end
        end

        context 'random range' do
          let(:bounds) { Range.new(*values.sample(2).sort) }

          specify do
            expect(splay_set.sum(bounds)).to eq(baseline_sum)
          end
        end

        context 'first and last values' do
          let(:bounds) { Range.new(*values.minmax) }

          specify do
            expect(splay_set.sum(bounds)).to eq(baseline_sum)
          end
        end

        context 'when right bound is bigger than max value' do
          let(:bounds) { Range.new(values.sample, values.max + 10) }

          specify do
            expect(splay_set.sum(bounds)).to eq(baseline_sum)
          end
        end

        context 'when left bound is less than min value' do
          let(:bounds) { Range.new(values.min - 1, values.sample) }

          specify do
            expect(splay_set.sum(bounds)).to eq(baseline_sum)
          end
        end

        context 'when bounds are equal' do
          let(:value) { values.sample }
          let(:bounds) { Range.new(value, value) }

          specify do
            expect(splay_set.sum(bounds)).to eq(baseline_sum)
          end
        end
      end
    end
  end

  describe '#find' do
    let(:values) { [1, 3, 0, 2] }
    let(:set) { values.reduce(described_class.new) { |s, v| s.insert(v) } }

    specify do
      expect(values.map { |v| set.find(v).node.value }).to eq(values)
    end
  end

  [2, 3, 4, 5, 8, 13, 21, 40, 128].each do |size|
    it_behaves_like 'splay tree set', size, :asc
    it_behaves_like 'splay tree set', size, :desc
    it_behaves_like 'splay tree set', size, :rand
  end

  describe '#empty?' do
    subject { described_class.new.empty? }

    it { is_expected.to eq(true) }

    context 'when node is set' do
      let(:node) { Exercise::SplaySet::Node.new(0) }

      subject { described_class.new(node: node).empty? }

      it { is_expected.to eq(false) }
    end
  end

  describe '#insert' do
    subject { described_class.new.insert(0) }

    it { is_expected.not_to be_empty }

    specify { expect(subject.node.value).to eq(0) }
  end

  describe '#sum' do
    subject(:splay_set) { described_class.new }

    specify do
      s = splay_set.insert(3)
      s = s.insert(5)
      expect(s.sum(2..4)).to eq(3)
      expect(s.sum(4..7)).to eq(5)
    end
  end

  describe '#find' do
    subject(:found) { described_class.new.find(42) }

    specify { expect(found).to be_empty }
  end
end
