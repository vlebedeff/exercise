module Exercise
  # Determines whether a set of elements can be partitioned in 3 subsets such that the sum of
  # elements in all 3 subsets is the same
  def balanced_partition3(items)
    sum_third, sum_mod3 = items.reduce(:+).divmod(3)
    return false unless sum_mod3.zero?
    table =
      Array.new(sum_third + 1) do |i|
        Array.new(sum_third + 1) do |j|
          Array.new(items.size + 1) { i.zero? || j.zero? ? true : false }
        end
      end

    1.upto(sum_third) do |i|
      1.upto(sum_third) do |j|
        1.upto(items.size) do |k|
          table[i][j][k] =
            table[i - items[k - 1]][j][k - 1] ||
            table[i][j - items[k - 1]][k - 1] ||
            table[i][j][k - 1]
        end
      end
    end
    table[sum_third][sum_third][items.size]
  end
end
