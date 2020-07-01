module Exercise
  RSpec.describe Trie do
    describe '#to_s' do
      example do
        expect(described_class.new([]).to_s).to eq('')
      end

      example do
        expect(described_class.new(['A']).to_s).to eq('0->1:A')
      end

      example do
        expect(described_class.new(['AC']).to_s).to eq("0->1:A\n1->2:C")
      end

      example do
        expect(described_class.new(['ACTG']).to_s).to eq(
          "0->1:A\n"\
          "1->2:C\n"\
          "2->3:T\n"\
          '3->4:G'
        )
      end

      example do
        expect(described_class.new(%w[AC TG]).to_s).to eq(
          "0->1:A\n"\
          "0->3:T\n"\
          "1->2:C\n"\
          '3->4:G'
        )
      end

      example do
        expect(described_class.new(['ATA']).to_s).to eq(
          "0->1:A\n"\
          "1->2:T\n"\
          '2->3:A'
        )
      end

      xexample do
        expect(described_class.new(%w[AT AG AC]).to_s).to eq(
          "0->1:A\n"\
          "1->2:T\n"\
          "1->3:G\n"\
          '1->4:C'
        )
      end
    end
  end
end
