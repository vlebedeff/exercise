module Exercise
  RSpec.describe ArithmExp do
    specify do
      expect(described_class.new('7+3-5*4+8-20').maximum).to eq(50)
    end
  end
end
