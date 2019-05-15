module Exercise
  class SplaySet
    attr_reader :node

    def initialize(node: nil, path: Stack.new)
      @node = node
      @path = path
    end

    def empty?
      node.nil?
    end

    def go_left
      return self unless node.left
      SplaySet.new(node.left, path.push(Step.new(node, :left)))
    end

    def go_right
      return self unless node.right
      SplaySet.new(node.right, path.push(Step.new(node, :right)))
    end

    def find(value)
      z = self
      loop do
        if z.node.value < value && z.node.right
          z = z.go_right
        elsif z.node.value > value && z.node.left
          z = z.go_left
        else
          return z
        end
      end
    end

    def splay
      z = self
      while z.path.any?
        z =
          if z.path.size == 1
            if z.last.direction == :left
              new_right = z.last.node.attach_left(z.node.right)
              SplaySet.new(node.attach_right(new_right))
            else
              new_left = z.last.node.attach_right(z.node.left)
              SplaySet.new(node.attach_left(new_left))
            end
          else
            z
          end
      end
    end

    Node = Struct.new(:value, :left, :right) do
      def attach_left(node)
        Node.new(value, node, right)
      end

      def attach_right(node)
        Node.new(value, left, node)
      end

      def sum
        @sum ||=
          begin
            l_sum = left ? left.sum : 0
            r_sum = right ? right.sum : 0
            l_sum + value + r_sum
          end
      end
    end

    Stack = Struct.new(:value, :prev, :size) do
      def initalize(*args)
        super
        self.size ||= 0
      end

      def push(value)
        Stack.new(value, self, size + 1)
      end

      def pop
        prev
      end

      def last
        value
      end

      def any?
        !value.nil?
      end
    end

    Step = Struct.new(:node, :direction)
  end
end
