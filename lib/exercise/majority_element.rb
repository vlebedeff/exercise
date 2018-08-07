module Exercise
  def majority_element(elements)
    return if elements.empty?
    majority_index = 0
    count = 1
    1.upto(elements.count - 1) do |i|
      count += elements[majority_index] == elements[i] ? 1 : -1
      if count.zero?
        majority_index = i
        count = 1
      end
    end
    candidate = elements[majority_index]
    elements.count(candidate) > elements.count / 2 ? candidate : nil
  end
end
