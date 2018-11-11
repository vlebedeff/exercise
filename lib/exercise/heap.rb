module Exercise
  class Heap
    def initialize(items = [], &block)
      @items = items
      max_index_with_children.downto(0) { |i| downheap(i, &block) }
    end

    def insert(value)
      @items << value
      upheap
    end

    def values
      @items
    end

    private

    def upheap(index = @items.size - 1)
      current = index
      parent = (current - 1) / 2
      while parent >= 0 && @items[current] < @items[parent]
        @items[current], @items[parent] = @items[parent], @items[current]
        current = parent
        parent = (current - 1) / 2
      end
    end

    def downheap(index = 0)
      current = index
      while children?(current)
        j = current + current + 1
        j += 1 if j < @items.size - 1 && @items[j] > @items[j + 1]
        break if @items[current] <= @items[j]
        yield current, j if block_given?
        @items[current], @items[j] = @items[j], @items[current]
        current = j
      end
    end

    def max_index_with_children
      @items.size / 2 - 1
    end

    def children?(index)
      index < @items.size / 2
    end
  end
end
