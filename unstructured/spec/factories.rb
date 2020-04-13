FactoryGirl.define do
  factory :graph_1, class: 'Graph' do
    initialize_with { new(true) }
    after(:build) do |graph|
      graph.add_edge(1, 2, 1)
      graph.add_edge(4, 1, 2)
      graph.add_edge(2, 3, 2)
      graph.add_edge(1, 3, 5)
    end
  end

  factory :graph_2, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(1, 2, 4)
      graph.add_edge(1, 3, 2)
      graph.add_edge(2, 3, 2)
      graph.add_edge(3, 2, 1)
      graph.add_edge(2, 4, 2)
      graph.add_edge(3, 5, 4)
      graph.add_edge(5, 4, 1)
      graph.add_edge(2, 5, 3)
      graph.add_edge(3, 4, 4)
    end
  end

  factory :graph_3, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(1, 2, 7)
      graph.add_edge(1, 3, 5)
      graph.add_edge(2, 3, 2)
    end
  end

  factory :graph_4, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(1, 2, -5)
      graph.add_edge(4, 1, 2)
      graph.add_edge(2, 3, 2)
      graph.add_edge(3, 1, 1)
    end
  end

  factory :graph_5, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(:s, :a, 4)
      graph.add_edge(:s, :b, 3)
      graph.add_edge(:a, :b, -2)
      graph.add_edge(:a, :c, 4)
      graph.add_edge(:b, :c, -3)
      graph.add_edge(:b, :d, 1)
      graph.add_edge(:c, :d, 2)
    end
  end

  factory :graph_6, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(:e, :a, 5)
      graph.add_edge(:b, :c, 3)
      graph.add_edge(:c, :e, 1)
      graph.add_edge(:e, :d, -2)
      graph.add_edge(:d, :c, -3)
    end
  end

  factory :graph_7, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(1, 2, 10)
      graph.add_edge(2, 3, 5)
      graph.add_edge(1, 3, 100)
      graph.add_edge(3, 5, 7)
      graph.add_edge(5, 4, 10)
      graph.add_edge(4, 3, -18)
      graph.add_edge(6, 1, -1)
    end
  end

  factory :graph_8, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(1, 2, 1)
      graph.add_edge(4, 1, 2)
      graph.add_edge(2, 3, 2)
      graph.add_edge(3, 1, -5)
    end
  end

  factory :graph_9, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(2, 3, -1)
      graph.add_edge(3, 2, -1)
      graph.add_edge(1, 4, 1)
      graph.add_edge(1, 5, 1)
      graph.add_edge(1, 6, 1)
      graph.add_edge(2, 4, 1)
      graph.add_edge(2, 5, 1)
      graph.add_edge(2, 6, 1)
    end
  end

  factory :graph_11, class: 'Graph' do
    initialize_with { new(true) }

    after(:build) do |graph|
      graph.add_edge(1, 2, 10)
      graph.add_edge(2, 3, 5)
      graph.add_edge(1, 3, 100)
      graph.add_edge(3, 5, 7)
      graph.add_edge(5, 4, 10)
      graph.add_edge(4, 3, -18)
      graph.add_edge(5, 1, -1)
    end
  end

  factory :'figure_4.3', class: 'BTree' do
    after_build do |tree|
      tree.root.data = 'E'
      tree.root.left = BTree::Node.new(
        'O',
        BTree::Node.new(
          nil,
          BTree::Node.new('A'),
          BTree::Node.new('C')
        ),
        BTree::Node.new(
          'P',
          BTree::Node.new('M'),
          BTree::Node.new('L')
        )
      )
      tree.root.right = BTree::Node.new(
        'T',
        BTree::Node.new(
          'E',
          BTree::Node.new('T'),
          BTree::Node.new(nil)
        ),
        BTree::Node.new(
          'E',
          BTree::Node.new('R'),
          BTree::Node.new('E')
        )
      )
    end
  end
end
