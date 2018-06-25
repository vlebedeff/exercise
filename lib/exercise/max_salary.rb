module Exercise
  def max_salary(numbers)
    numbers.sort { |a, b| (b.to_s + a.to_s).to_i <=> (a.to_s + b.to_s).to_i }.join.to_i
  end
end
