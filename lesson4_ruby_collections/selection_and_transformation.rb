# frozen_string_literal: true

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

# Exercise: Implement the select_fruit method

def select_fruit(produce)
  produce.select { |_, type| type == 'Fruit' }

  # Imperatively, one would use a while loop with an if statement to build a new hash.
  # Create a new hash object
  # Get all hash keys as array
  # Loop through each hash key
  # type = hash[key]
  # if type = "Fruit", add the key-value pair to the new hash object
  #   Consider using clone to ensure values in original hash are unmodified.
end

p select_fruit(produce) == { 'apple' => 'Fruit', 'pear' => 'Fruit' }

# =============
# Exercise: Imperatively implement double_numbers! method that doubles all numbers in an array, mutating the caller.

def double_numbers!(numbers)
  counter = 0

  while counter < numbers.size
    numbers[counter] *= 2
    counter += 1
  end

  numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
double_numbers!(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers == [2, 8, 6, 14, 4, 12]

# =============
# Exercise: What if we wanted to transform the numbers based on their position in the array rather than their value?
# Try coding a solution that doubles the numbers that have odd indices.

def double_odd_indices(numbers)
  new_numbers = []
  counter = 0

  loop do
    break new_numbers if counter == numbers.size

    new_numbers << (counter.odd? ? numbers[counter] * 2 : numbers[counter])

    counter += 1
  end
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_odd_indices(my_numbers) == [1, 8, 3, 14, 2, 12]

# =============
# Exercise: Try coding a method that allows you to multiply every array item by a specified value.

def multiply(numbers, factor)
  new_numbers = []
  counter = 0

  while counter < numbers.size
    new_numbers << numbers[counter] * factor
    counter += 1
  end

  new_numbers
end

p multiply([1, 4, 3, 7, 2, 6], 3) == [3, 12, 9, 21, 6, 18]
