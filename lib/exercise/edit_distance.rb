module Exercise
  def edit_distance(s1, s2)
    table = Array.new(s1.size + 1) { |i| Array.new(s2.size + 1) { |j| i + j } }
    1.upto(s1.size) do |i|
      1.upto(s2.size) do |j|
        table[i][j] =
          [
            table[i][j - 1] + 1,
            table[i - 1][j] + 1,
            table[i - 1][j - 1] + (s1[i - 1] == s2[j - 1] ? 0 : 1)
          ].min
      end
    end
    table[s1.size][s2.size]
  end
end
