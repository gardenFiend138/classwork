# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

=begin
I realized I messed up here in splitting the string on each character, but
the below code still passed 2 tests, so I went back to this version.
My (non)working solution for multiple words is :

def caesar_cipher(str, shift)
  letters = ("a".."z").to_a
  result = ""
  words = str.split(" ")

  words.each do |word|
    temp_word = []
    word.split("").each do |letter|
      temp_word = ""
      alphabet_index = letters.find_index(letter)
      new_letter_index = (alphabet_index + shift.to_i)

      if new_letter_index > 25
        new_letter_index -= 26
      end

      temp_word += letters[new_letter_index]
      p temp_word
    end
    result << temp_word
  end
  p result
  result

end

=end
def caesar_cipher(str, shift)
  letters = ("a".."z").to_a
  result = ""
  words = str.split("")

  words.each do |word|
    word.split(//).each do |letter|
      word = ""
      alphabet_index = letters.find_index(letter)
      new_letter_index = (alphabet_index + shift.to_i)

      if new_letter_index > 25
        new_letter_index -= 26
      end

      word = letters[new_letter_index]
      # p word
    end
    result += word
  end
  result

end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

# Example:
# digital_root(4322) => 2
# (4 + 3 + 2 + 2) => 11 => (1 + 1) => 2
def digital_root_step(num)
  digits = []

  while num > 9
    digits << num % 10
    num /= 10
  end
  digits << num
end
# Definitely need more work with recursion before doing this problem,
# although it does seem like it's pretty straightforward...
# Okay, I got it...when I run some tests on it, it seems to work,
# but it isn't currently passing any of the tests in the specs...
def digital_root(num)
  digits = digital_root_step(num)
  sum = 0

  return digits.first if digits.length == 1
  # if digits.length == 1
  #   return digits.first
  # end

  digits.each { |digit| sum += digit }

  digital_root(sum)

end

p digital_root(4322) == 2
p digital_root(9) == 9
p digital_root(11) == 2

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  if alphabet == nil
    alphabet = ("a".."z").to_a
  end

  result = []
  letter_frequency = Hash.new(0)
  new_alphabet_indices = {}

  str.split("").each do |letter|
    letter_frequency[letter] += 1
    new_alphabet_indices[letter] = alphabet.find_index(letter)
  end

  new_order = new_alphabet_indices.sort_by { |_key, value| value }

  new_order.each do |sorted_value|
    letter_frequency[sorted_value[0]].times { result << sorted_value[0] }
  end
  result.join

end

p jumble_sort("hello", ['o', 'l', 'h', 'e']) == "ollhe"
p jumble_sort("hello") == "ehllo"

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    zero_sums = []
    self.each_with_index do |num, idx|
      ((idx + 1)...self.length).each do |idx2|
        if self[idx] + self[idx2] == 0
          zero_sums << [idx, idx2]
        end
      end
    end
    zero_sums
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    sub_words = []

    self.split("").each_with_index do |letter, idx|
      sub_words << letter if dictionary.include?(letter)
      ((idx + 1)...self.length).each do |idx2|
        current_subword = (self[idx..idx2]).to_s
        # p current_subword
        if dictionary.include?(current_subword)
          sub_words << current_subword
        end
      end
    end
    sub_words.uniq
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  factors = []
  (1..num).to_a.each { |el| factors << el if num % el == 0 }
  factors
end
