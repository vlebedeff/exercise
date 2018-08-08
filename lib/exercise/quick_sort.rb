module Exercise
  def quick_sort(items) # rubocop:disable Metrics/AbcSize
    a = items.dup
    stack = [0, items.count - 1]
    while stack.any?
      l, r = stack.pop(2)
      while l < r
        pivot_l, pivot_r = quick_sort_partition(a, l, r)

        if pivot_l - l > r - pivot_r
          stack << l << pivot_l - 1
          l = pivot_r + 1
        else
          stack << pivot_r + 1 << r
          r = pivot_l - 1
        end
      end
    end
    a
  end

  def quick_sort_partition(a, l, r) # rubocop:disable Metrics/AbcSize
    k = l + rand(r - l)
    a[l], a[k] = a[k], a[l]
    pivot_l = pivot_r = l
    pivot = a[l]
    (l + 1).upto(r) do |i|
      if a[i] == pivot
        a[i], a[pivot_r + 1] = a[pivot_r + 1], a[i]
        pivot_r += 1
      elsif a[i] < pivot
        a[i], a[pivot_l], a[pivot_r + 1] = a[pivot_r + 1], a[i], a[pivot_l]
        pivot_l += 1
        pivot_r += 1
      end
    end
    [pivot_l, pivot_r]
  end
end
