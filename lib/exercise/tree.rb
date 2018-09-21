module Exercise
  class Tree
    attr_reader :parent_index

    def initialize(parent_index = [])
      @parent_index = parent_index
    end

    def root
      @root ||= parent_index.index(-1)
    end

    def children
      @children ||=
        begin
          0.upto(parent_index.size - 1).each_with_object([]) do |i, ch|
            next if i == root
            parent = parent_index[i]
            ch[parent] ||= []
            ch[parent] << i
          end
        end
    end

    def height
      @height = []
      @height[root] = 1
      @tree_height = 1
      queue = children[root] || []
      while queue.any?
        node = queue.shift
        @height[node] = @height[parent_index[node]] + 1
        @tree_height = @height[node]
        queue = children[node].nil? ? queue : queue + children[node]
      end
      @tree_height
    end
  end
end
