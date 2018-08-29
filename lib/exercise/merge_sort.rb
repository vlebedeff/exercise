module Exercise
  def merge_sort(items)
    return [items, 0] if items.count < 2
    m = items.count / 2
    a, a_invs = merge_sort(items[0..m - 1])
    b, b_invs = merge_sort(items[m..-1])
    c, invs = merge(a, b)
    [c, invs + a_invs + b_invs]
  end

  def merge(a, b)
    c = []
    inversions = 0
    while a.any? && b.any?
      c << if a[0] <= b[0]
             a.shift
           else
             inversions += a.count
             b.shift
           end
    end
    [c + a + b, inversions]
  end
end
