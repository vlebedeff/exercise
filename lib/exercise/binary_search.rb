module Exercise
  def binary_search(items, item)
    left = 0
    right = items.size - 1
    while left <= right
      return left if items[left] == item
      middle = left + (right - left) / 2
      if items[middle] < item
        left = middle + 1
      elsif items[middle] > item
        right = middle - 1
      else
        return middle
      end
    end
    nil
  end
end
