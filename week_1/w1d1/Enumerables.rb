class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    result = []
    self.my_each do |el|
      if prc.call(el)
        result << el
      end
    end
    result
  end

  def my_reject(&prc)
    result = []
    self.my_each do |el|
      if !prc.call(el)
        result << el
      end
    end
    result
  end

  def my_any?(&prc)
    self.my_each { |el| return true if prc.call(el) }
    false
  end

  # def my_all?(&prc)
  #   result = []
  #   self.my_each do |el|
  #     if prc.call(el)
  #       result << el
  #     end
  #   end
  #   self == result
  # end

  def my_all?(&prc)
    self.each { |el| return false if !prc.call(el) }
    true
  end

  def my_flatten
    result = []
    self.my_each do |el|
      if !el.is_a?(Array)
        result << el
      else
        result += el.my_flatten
      end
    end
    result
  end

  def my_zip(*args)
    arguments = args
    result = []
    self.each_with_index do |el, idx|
      result << [el]
      arguments.each do |arg_el|
        result[idx] << arg_el[idx]
      end
    end
    result
  end

  def my_rotate(shift = 1)
    while shift < self.length * -1
      shift += self.length
    end

    while shift >= self.length
      shift -= self.length
    end

    result = []
    self.each_with_index do |el, idx|
      if idx + shift >= self.length
        idx -= self.length
      end
      result << self[idx + shift]
    end
    result
  end

  def my_join(separator = "")
    result = ""
    self.each do |el|
      result += el + separator
    end
    result[0...(separator.length * -1)]
  end

  def my_reverse
    res = []
    self.each do |ele|
      res = [ele] + res
    end
    res
  end

  def bubble_sort!(&prc)
    pre, post = -1, 1
    while pre != post
      pre = self.dup
      self.each_with_index do |el, idx|
        next if idx == self.length - 1
        if prc.call(el, self[idx + 1]) > 0
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
        end
      end
      post = self.dup
    end
    self
  end

  def bubble_sort(&prc)
    result = self.dup
    result.bubble_sort!(&prc)
  end
end

def substrings(string)
  ret_array = []

  string.chars.each_with_index do |char1, start_idx|
    (start_idx...string.length).each do |end_idx|
      ret_array << string[start_idx..end_idx]
    end
  end
  ret_array.uniq
end

def subwords(string, dictionary)
  sub_strings = substrings(string)
  ret_array = []

  sub_strings.each do |str|
    ret_array << str if dictionary.include?(str)
  end
  ret_array

end

def factors(num)
  factors = []
  (1..num).each { |num2| factors << num2 if num % num2 == 0 }
  factors
end
