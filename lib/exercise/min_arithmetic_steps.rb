module Exercise
  def min_arithmetic_steps(n, operations)
    from = [0, 1]
    steps = [0, 0]
    1.upto(n) do |i|
      step = steps[i] + 1
      operations.each do |op|
        op_result = op.call(i)
        if op_result <= n && (!steps[op_result] || steps[op_result] > step)
          steps[op_result] = step
          from[op_result] = i
        end
      end
    end

    history = [n]
    history.unshift(from[history.first]) while history.first != 1
    history
  end
end
