module Exercise
  class BinaryTree
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def each_in_order
      return to_enum(:each_in_order) unless block_given?
      return if data.empty?
      current = 0
      stack = []
      done = false
      until done
        if current
          stack << current
          current = left(current)
        elsif stack.any?
          current = stack.pop
          yield value(current)
          current = right(current)
        else
          done = true
        end
      end
    end

    def each_pre_order
      return to_enum(:each_pre_order) unless block_given?
      return if data.empty?
      stack = [0]
      while stack.any?
        current = stack.pop
        yield value(current)
        stack += [right(current), left(current)].compact
      end
    end

    private

    def value(i)
      data[i][0]
    end

    def left(i)
      data[i][1]
    end

    def right(i)
      data[i][2]
    end
  end
end
