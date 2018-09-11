module Exercise
  RSpec.describe '#edit_distance' do
    include Exercise

    let(:examples) do
      [['kitten', 'sitting', 3],
       ['saturday', 'sunday', 3],
       ['tuesday', 'thursday', 2],
       ['hematology', 'hepatology', 1]]
    end

    specify do
      examples.each do |s1, s2, expected_distance|
        expect(edit_distance(s1, s2)).to eq(expected_distance)
      end
    end
  end
end
