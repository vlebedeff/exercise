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

      example do
        expect(described_class.new(%w[AT AG AC]).to_s).to eq(
          "0->1:A\n"\
          "1->2:T\n"\
          "1->3:G\n"\
          '1->4:C'
        )
      end

      example do
        expect(described_class.new(%w[ATAGA ATC GAT]).to_s).to eq(
          "0->1:A\n"\
          "0->7:G\n"\
          "1->2:T\n"\
          "2->3:A\n"\
          "2->6:C\n"\
          "3->4:G\n"\
          "4->5:A\n"\
          "7->8:A\n"\
          '8->9:T'
        )
      end
    end

    describe '#match' do
      example do
        expect(described_class.new(%w[AA]).match('AAA')).to eq([0, 1])
      end

      example do
        expect(described_class.new(%w[AA]).match('G')).to eq([])
      end

      example do
        expect(described_class.new(%w[ATCG GGGT]).match('AATCGGGTTCAATCGGGGT')).to eq(
          [1, 4, 11, 15]
        )
      end

      it 'finds overlapping patterns in text' do
        expect(described_class.new(%w[AT A AG]).match('ACATA')).to eq([0, 2, 4])
      end
    end
  end
end
