module Exercise
  class DisjointSet
    attr_reader :size

    def initialize(items = [])
      @elements = items.uniq
      @index = @elements.each_with_index.each_with_object({}) { |(el, i), h| h[el] = i }
      @size = @elements.size
      @rank = Array.new(@size) { 0 }
      @parent = Array.new(@size) { |i| i }
    end

    def find(element)
      @elements[root_idx(element)]
    end

    def union(name1, name2)
      root1 = root_idx(name1)
      root2 = root_idx(name2)
      return if root1 == root2
      root, child =
        if @rank[@index[name1]] < @rank[@index[name2]]
          @parent[root1] = root2
          [root2, root1]
        else
          @rank[@index[name1]] += 1 if @rank[@index[name1]] == @rank[@index[name2]]
          @parent[root2] = root1
          [root1, root2]
        end
      @size -= 1
      yield @index[root], @index[child] if block_given?
    end

    private

    def root_idx(element)
      while grandparent_idx(element) != parent_idx(element)
        @parent[parent_idx(element)] = great_grandparent_idx(element)
        @parent[@index[element]] = grandparent_idx(element)
      end
      @parent[@index[element]]
    end

    def parent_idx(element)
      @parent[@index[element]]
    end

    def grandparent_idx(element)
      @parent[parent_idx(element)]
    end

    def great_grandparent_idx(element)
      @parent[grandparent_idx(element)]
    end
  end
end
