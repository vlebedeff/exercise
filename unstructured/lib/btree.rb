class BTree

  attr_reader :root

  def initialize(data = nil)
    @root = Node.new(data)
    @root
  end

  class Node
    attr_accessor :left, :right, :data

    def initialize(data, left = nil, right = nil)
      @data = data
      @left = left
      @right = right
    end
  end

  class PreOrderVisitor

    def self.foreach(node)
      return to_enum(:foreach, node) unless block_given?

      if node
        # yield node
        # foreach(node.left) { |x| yield x }
        # foreach(node.right) { |x| yield x }
        stack = [node]
        while stack.any?
          x = stack.pop
          yield x
          stack << x.right if x.right
          stack << x.left if x.left
        end
      end
    end
  end

  class InOrderVisitor

    def self.foreach(node)
      return to_enum(:foreach, node) unless block_given?

      if node
        # foreach(node.left) { |x| yield x }
        # yield node
        # foreach(node.right) { |x| yield x }
        stack = []
        current = node
        done = false
        while !done
          if current
            stack << current
            current = current.left
          else
            if stack.any?
              current = stack.pop
              yield current
              current = current.right
            else
              done = true
            end
          end
        end
      end
    end
  end

  class PostOrderVisitor

    def self.foreach(node)
      return to_enum(:foreach, node) unless block_given?

      if node
        # foreach(node.left) { |x| yield x }
        # foreach(node.right) { |x| yield x }
        # yield node
        stack = []
        current = node
        loop do
          while current
            stack << current.right if current.right
            stack << current
            current = current.left
          end
          current = stack.pop
          if current.right && current.right == stack.last
            current, stack[-1] = stack[-1], current
          else
            yield current
            current = nil
          end
          break if stack.empty?
        end
      end
    end
  end

  class LevelOrderVisitor

    def self.foreach(node)
      return to_enum(:foreach, node) unless block_given?

      queue = [node]
      while queue.any?
        n = queue.shift
        yield n
        queue.push(n.left) if n.left
        queue.push(n.right) if n.right
      end
    end
  end
end
