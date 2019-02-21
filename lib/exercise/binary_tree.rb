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
        stack << right(current) if right(current)
        stack << left(current) if left(current)
      end
    end

    def each_post_order # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
      return to_enum(:each_post_order) unless block_given?
      return if data.empty?
      stack = []
      current = 0
      loop do
        while current
          stack << right(current) if right(current)
          stack << current
          current = left(current)
        end
        current = stack.pop
        current_right = right(current)
        if current_right && current_right == stack.last
          current, stack[-1] = stack[-1], current
        else
          yield value(current)
          current = nil
        end
        break if stack.empty?
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
