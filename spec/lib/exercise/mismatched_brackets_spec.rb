RSpec.describe '#mismatched_brackets' do
  include Exercise
  let(:examples) do
    {
      '({[]})' => nil,
      '{}[]()' => nil,
      'foo(bar[i);' => 9,
      '[[})' => 2,
      '[{)(){]' => 2,
      '[[]}]{}' => 3,
      '{' => 0
    }
  end

  specify do
    examples.each do |text, result|
      expect(mismatched_brackets(text)).to eq(result)
    end
  end
end
