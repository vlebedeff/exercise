module Exercise
  def lcs(s1, s2)
    table = Array.new(s1.size + 1) { Array.new(s2.size + 1) { 0 } }
    1.upto(s1.size) do |i|
      1.upto(s2.size) do |j|
        table[i][j] =
          if s1[i - 1] == s2[j - 1]
            table[i - 1][j - 1] + 1
          else
            [table[i][j - 1], table[i - 1][j]].max
          end
      end
    end
    table[s1.size][s2.size]
  end

  def lcs3(s1, s2, s3)
    table = Array.new(s1.size + 1) { Array.new(s2.size + 1) { Array.new(s3.size + 1) { 0 } } }
    1.upto(s1.size) do |i|
      1.upto(s2.size) do |j|
        1.upto(s3.size) do |k|
          table[i][j][k] =
            if s1[i - 1] == s2[j - 1] && s1[i - 1] == s3[k - 1]
              table[i - 1][j - 1][k - 1] + 1
            else
              [
                table[i][j][k - 1],
                table[i][j - 1][k],
                table[i][j - 1][k - 1],
                table[i - 1][j][k],
                table[i - 1][j][k - 1],
                table[i - 1][j - 1][k]
              ].max
            end
        end
      end
    end
    table[s1.size][s2.size][s3.size]
  end
end
