# frozen_string_literal: true

require "merge_sort"

RSpec.describe MergeSort do
  it "correctly sorts an empty array" do
    expect(MergeSort.merge_sort([])).to eql([])
  end

  it "correctly sorts an array with one element" do
    expect(MergeSort.merge_sort([3])).to eql([3])
  end

  it "correctly sorts an array with an odd number of elements" do
    array = [59, 95, 88, 48, 32, 42, 40, 19, 98, 22, 29]
    sorted_array = [19, 22, 29, 32, 40, 42, 48, 59, 88, 95, 98]
    expect(MergeSort.merge_sort(array)).to eql(sorted_array)
  end

  it "correctly sorts an empty with an even number of elements" do
    array = [48, 8, 89, 16, 60, 36, 44, 4, 2, 6, 25, 78]
    sorted_array = [2, 4, 6, 8, 16, 25, 36, 44, 48, 60, 78, 89]
    expect(MergeSort.merge_sort(array)).to eql(sorted_array)
  end
end
