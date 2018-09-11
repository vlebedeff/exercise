module Exercise
  RSpec.describe '#lcs' do
    include Exercise

    let(:examples) do
      [['kitten', 'sitting', 4],
       ['saturday', 'sunday', 5],
       ['tuesday', 'thursday', 6],
       ['hematology', 'hepatology', 9]]
    end

    specify do
      examples.each do |s1, s2, expected_lcs|
        expect(lcs(s1, s2)).to eq(expected_lcs)
      end
      expect(lcs3('AAAGAGTTCGT', 'ACATTTCCC', 'AGCCTGCTGTCCCAGA')).to eq(4)
    end
  end
end
