# frozen_string_literal: true

# Implementation of the merge sort algorithm. The method #merge_sort sorts the given array.
module MergeSort
  def self.merge_sort(array)
    return array unless array.length > 1

    mid = array.length / 2
    left = merge_sort(array[...mid])
    right = merge_sort(array[mid..])
    merge(left, right)
  end

  def self.merge(left, right)
    merged = []
    i = j = 0
    while i < left.length && j < right.length
      if left[i] < right[j]
        merged.push(left[i])
        i += 1
      else
        merged.push(right[j])
        j += 1
      end
    end
    merged + left[i..] + right[j..]
  end
end
