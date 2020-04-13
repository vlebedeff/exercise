require 'spec_helper'
require 'heap'

describe Heap do
  subject { Heap.new }

  specify do
    'EASYQUESTION'.each_char do |ch|
      subject.insert(ch)
    end
    expect(subject.remove).to eq('Y')
    expect(subject.remove).to eq('U')
    expect(subject.remove).to eq('T')
    expect(subject.remove).to eq('S')
    expect(subject.remove).to eq('S')
    expect(subject.remove).to eq('Q')
    expect(subject.remove).to eq('O')
    expect(subject.remove).to eq('N')
    expect(subject.remove).to eq('I')
    expect(subject.remove).to eq('E')
    expect(subject.remove).to eq('E')
    expect(subject.remove).to eq('A')
    expect { subject.remove }.to raise_error('Empty Heap')
  end
end
