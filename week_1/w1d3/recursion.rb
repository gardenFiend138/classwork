require 'byebug'

# Once again you were bit by not paying attention to data types of return
# values multiple times today; in both subsets and permutations, you were
# attempting to return the variable "arr", even though at its base case
# it was an integer. Pay closer attention to this--the fix in each case
# was to throw the base case return value in brackets (i.e. arr => [arr]);
# or better yet, remember to handle how to ensure that nil is returned in the
# proper data type.

def range(start_num, end_num)
  return [] if end_num < start_num
  return [start_num] if end_num - start_num == 1
  result = [start_num]
  result + range(start_num + 1, end_num)
end
=begin
Comparing the two range solutions, I see that the required base case is an empty
array. This is because once min == max, then there is no range. From here,
we recursively call #range_2, passing in the original min value, and derementing
the max by 1. This will lead us to our base case. Since range_2 returns
an array, there is no need to declare a return variable, since it is by
default returning an array, even though we are using the shovel operator,
which usually returns only that which is shoveled in; different here due
to recursive solution
=end

def range_2(min, max)
  return [] if min >= max
  range_2(min, max - 1) << max - 1
end

def iterative_range(start_num, end_num)
  return [] if end_num < start_num
  result = []
  (start_num...end_num).each do |num|
    result << num
  end
  result
end

=begin
So, we forgot to do this one yesterday during class I guess...
Our base case is that there are no numbers left in the array of numbers.
This is necessary to account for being passed an empty array. I would have
leaned towards the base case being an array of length 1, since we can just
return the only number in that array, but I would then have to account
for being passed an empty array as an argument.
=end
def sum_nums(nums)
  return 0 if nums.empty?
  sum_nums(nums[0...-1]) + nums[-1]
end

def exponent(base, power)
  return 1 if power == 0
  return base if power == 1
  base * exponent(base, power - 1)
end
=begin
Comparing the solution to ours for exponenet1, like in the second exp
method, we have a superflous early return. Keep in mind that additional
returns are only needed for error handling; otherwise, a base case will
suffice.
=end
def exp1(base, power)
  return 1 if power == 0
  base * exp1(base, power - 1)
end

def exp2(base, power)
  return 1 if power == 0

  half = exp2(base, (power / 2))
  if power.even?
    half * half
  else
    # base * half * half, because when pwoer.odd?, power / 2 == power - 1 / 2
    # on account of rounding down division value for integer division
    base * exp2(base, (power - 1) / 2) * exp2(base, (power - 1) / 2)
  end
end

=begin
 It looks like our second base case
isn't necessary, which makes sense, because if our atual base case is
correct, then we will only need early return statements for error
handling if necessary. In th
=end

def exp2(base, power)
  return 1 if power == 0
  return base if power == 1
  if power.even?
    exp2(base, power / 2) * exp2(base, power / 2)
  else
    base * exp2(base, (power - 1) / 2) * exp2(base, (power - 1) / 2)
  end
end

class Array
  def deep_dup_2(arr)
    arr_copy = []
    self.each do |el|
      arr_copy << (el.is_a?(Array) ? deep_dup_2(el) : el )
    end
  end

=begin
I really like the ternary operator in the above solution, especially
how the ternary is in parenthesis, and the result of whatever comes out
of the ternary is shoveled into the copy array.

***Also, due to the nature of the enumerables used on the input, no base case
had to be returned explicitly, since the default return value of using map,
each, and inject is the base case...DANG!***

Also, I like this map method:

def deep_dup_map(arr)
  self.map { |el| el.is_a?(Array) ? el.deep_dup_map : el }
end

Here is also an inject/ reduce method, but I'm not as comfortable using
it:

def deep_dup_inject(arr)
  inject([]) { |copy, el| copy << (el.is_a?(Array) ? el.deep_dup_inject : el)}
end

=end
  def deep_dup

    arr_copy = []

    self.each do |el|
      if el.is_a?(Array)
        arr_copy << el.deep_dup
      else
        arr_copy << el
      end
    end
    arr_copy
  end
end

def fibonacci(num)
  # return [0] if num == 1
  # return [1] if num == 2
  # Had to fix our base case, since when asking for either the first or second
  # fib numbers, was returning only one number; added in if/ else statement
  if num <= 2
    [0, 1].take(num)
  else
    result = fibonacci(num - 1)
    result << result[-2] + result[-1]
  end
    # result; by explicitly returning result here, I would also need to
    # add a return statement for the bae case, since with result outside
    # of the if..else statement, the expressions within the if..else are
    # no longer the last lines evaluated
end

=begin
In our base case, we incorretly began the sequence at [1,1], when in reality
it can be obtained from [0,1]
Okay, so comparing our fib mthods: the solution used take() to handle
having two base cases, which I really like the look of, is much more concise.
Then, we set the fib set to be equal to the fib set of n - 1, and then
shovel onto that the sum of the last two elements in the sequence. Very
similar to ours, but with a clearer base case.
=end

def fibs(n)
  if n <= 2
    [0,1].take(n) # This will take the first n elements from the array
  else
    fibs = fibs(n - 1)
    fibs << fibs[-2] + fibs[-1]
  end
end

def subset(arr)
  return [arr] if arr.empty?
  # return [[], arr] if arr.length == 1 this is not needed
  result = subset(arr[0...-1])

  result.length.times do |i|
    result[i] << arr.last
  end
  subset(arr[0...-1]) + result
end

=begin
In our permutations solution, the partial_result variable is useless,
since we are only recursively calling our method once, the result will
never be reset to an empty array.
=end
def permutation(arr)
  return [arr] if arr.length <= 1
  permutations = permutation(arr[0...-1])
  result = []
  permutations.each do |perm|
    partial_result = []
    (0..perm.length).each do |idx|
      partial_result = perm[0...idx] + [arr.last] + perm[idx..-1]
      result << partial_result
    end
  end
  result
end
