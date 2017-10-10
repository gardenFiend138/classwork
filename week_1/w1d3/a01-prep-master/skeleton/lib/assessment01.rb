# [1, 2, 3, 4, 5].inject { |acc, el| accu + 2 }
class Array
def my_inject(accumulator = nil, &block)
  accumulator = self.shift if accumulator == nil

  self.each do |el|
    accumulator = block.call(accumulator, el)
  end
  accumulator
end
end

def is_prime?(num)
  (2...num).none? { |i| num % i == 0 }
end

def primes(num)
  prime_numbers = []

  i = 2
  while prime_numbers.length < num
    prime_numbers << i if is_prime?(i)
    i += 1
  end
  prime_numbers
end

def factorials_rec(num)
  return [1] if num < 2
  facts = factorials_rec(num - 1)
  facts << (num - 1) * facts.last
end

class Array
def dups
  duplicates = Hash.new { |h, k| h[k] = [] }

  self.each_with_index do |el, idx|
    duplicates[el] << idx if self.count(el) > 1
  end
  duplicates

end
end

class String
def symmetric_substrings
  palindromes = []
  letters = self.split("")

  letters.each_index do |idx|
    ((idx + 1)...self.length).each do |idx2|
      substring = self[idx..idx2]
      palindromes << substring if substring == substring.reverse
    end
  end
  palindromes

end
end

class Array
# [3]
# [3, 1, 4, 2]
  def merge_sort(&prc)
    # return nil if self.length < 1
    return self if self.length <= 1

    prc ||= Proc.new { |x, y| x <=> y }
    mid = self.length / 2

    sorted_left = self.dup.take(mid).merge_sort(&prc)
    sorted_right = self.dup.drop(mid).merge_sort(&prc)

    self.class.merge(sorted_left, sorted_right, &prc)

  end

  private

  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end 
    merged.concat(left)
    merged.concat(right)
    merged

  end

end
