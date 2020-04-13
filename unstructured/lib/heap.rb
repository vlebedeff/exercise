class Heap

  def initialize
    @items = [Sentinel::Maximum.new]
  end

  def insert(item)
    @items << item
    upheap
  end

  def remove
    raise RuntimeError.new('Empty Heap') if @items.size < 2
    return @items.pop if @items.size == 2
    value = @items[1]
    @items[1] = @items.pop
    downheap
    value
  end

  private

  def upheap
    index = @items.size - 1
    parent = (index - 1) / 2
    while @items[index] > @items[parent]
      @items[index], @items[parent] = @items[parent], @items[index]
      index = parent
      parent = (index - 1) / 2
    end
  end

  def downheap
    i = 1
    while (i < @items.size / 2)
      j = i + i
      j += 1 if j < @items.size - 1 && @items[j] < @items[j+1]
      break if @items[i] >= @items[j]
      @items[i], @items[j] = @items[j], @items[i]
      i = j
    end
  end
end

module Sentinel
  class Maximum
    include Comparable

    def <=>(other)
      1
    end
  end
end
