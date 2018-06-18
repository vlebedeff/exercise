module Exercise
  def distinct_summands(n)
    summands = [0]
    while n > summands.last
      summands << summands.last + 1
      n -= summands.last
    end
    summands[-1] = summands[-1] + n
    summands[1..-1]
  end
end
