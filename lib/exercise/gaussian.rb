module Exercise
  def gaussian_elimination(m)
    w = Array.new(m.count) { |i| Array.new(m[i].count) { |j| m[i][j].to_f } }

    0.upto(w.count - 2) do |i| # for each line i
      # Find the best pivot line to mitigate round-off error
      pivot = i.upto(w.count - 1).max_by { |row| w[row][i].abs }
      w[i], w[pivot] = w[pivot], w[i]

      (i + 1).upto(w.count - 1) do |j| # for each line below i
        factor = w[j][i] / w[i][i]
        0.upto(w[j].count - 1) { |k| w[j][k] -= w[i][k] * factor }
      end
    end

    # Substitute values from REF matrix
    s = Array.new(w.count) { 0 }
    (s.count - 1).downto(0) do |i|
      s[i] =
        (
          w[i][w.count] -
          (i + 1).upto(s.count - 1).map { |j| w[i][j] * s[j] }.inject(0, :+)
        ) /
        w[i][i]
    end

    s.map { |x| x.round(12) }
  end
end
