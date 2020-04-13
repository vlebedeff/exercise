module Sorting
  class Method
    
    def initialize(ary)
      @ary = ary
    end  
  end

  class Quick < Method
    
    def sort
      ary = @ary.dup
      partition_and_sort(ary, 0, ary.size - 1)
      ary
    end

    private

    def partition_and_sort(a, l, r)
      stack = []
      while true
        while l < r
          k = l + rand(r - l)
          a[l], a[k] = a[k], a[l]
          m1, m2 = three_way_partition(a, l, r)

          if (m1 - l > r - m2)
            stack << l << m1 - 1
            l = m2 + 1
          else
            stack << m2 + 1 << r
            r = m1 - 1
          end
        end
        break if stack.empty?
        l, r = stack.pop(2)
      end
    end

    def three_way_partition(a, l, r)
      m1 = m2 = l
      pivot = a[l]
      (l + 1).upto(r) do |i|
        if a[i] == pivot
          a[i], a[m2 + 1] = a[m2 + 1], a[i]
          m2 += 1
        elsif a[i] < pivot
          a[i], a[m1], a[m2 + 1] = a[m2 + 1], a[i], a[m1]
          m1 += 1
          m2 += 1
        end
      end
      [m1, m2]
    end
  end

  class Shell < Method
    GAPS = [701,301,132,57,23,10,4,1]
    
    def sort
      ary = @ary.dup
      GAPS.each do |gap|
        gap.upto(ary.size - 1) do |i|
          v, j = ary[i], i
          while ary[j - gap] > v && j >= gap
            ary[j] = ary[j - gap]
            j -= gap
          end
          ary[j] = v
        end
      end
      ary
    end 
  end

  class Selection < Method
   
    def sort
      ary = @ary.dup
      0.upto(ary.size - 2) do |i|
        min = i
        (i + 1..ary.size - 1).each { |j| min = j if ary[j] < ary[min] }
        ary[i], ary[min] = ary[min], ary[i] unless i == min
      end
      ary
    end 
  end

  class Insertion < Method
    def sort
      ary = @ary.dup 
      1.upto(ary.size - 1) do |i|
        v, j = ary[i], i
        while ary[j - 1] > v && j > 0
          ary[j] = ary[j - 1]
          j -= 1
        end
        ary[j] = v
      end
      ary
    end
  end

  class Bubble < Method
    def sort
      ary = @ary.dup
      (ary.size - 2).downto(0) do |i|
        0.upto(i) do |j|
          ary[j], ary[j + 1] = ary[j + 1], ary[j] if ary[j + 1] < ary[j]
        end
      end
      ary
    end
  end
end
