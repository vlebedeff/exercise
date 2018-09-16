module Exercise
  def mismatched_brackets(text)
    stack = []
    0.upto(text.size - 1) do |i|
      char = text[i]
      if ['()', '{}', '[]'].include?("#{(text[stack.last] if stack.last)}#{char}")
        stack.pop
      elsif ['[', '(', '{'].include?(char)
        stack.push(i)
      elsif [']', ')', '}'].include?(char)
        return i
      end
    end
    stack.first
  end
end
