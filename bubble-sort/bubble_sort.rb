# frozen_string_literal: true

def bubble_sort(array)
  (array.length - 1).downto(1) do |i|
    0.upto(i - 1) do |j|
      array[j], array[j + 1] = array[j + 1], array[j] if array[j] > array[j + 1]
    end
  end
  array
end

p bubble_sort([4, 3, 78, 2, 0, 2])
