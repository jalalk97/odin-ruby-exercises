# frozen_string_literal: true

# This class represents a balanced binary search tree.
class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.length - 1) / 2
    Node.new(array[mid], build_tree(array[...mid]), build_tree(array[mid + 1..]))
  end

  def pretty_print(node = @root, prefix = "", is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", is_left: true) if node.left
  end

  # This class represents a node in a binary search tree. Each node has most two possibly nil children of type Node
  # represented by the instance variables left and right.
  class Node
    include Comparable
    attr_accessor :data, :left, :right

    def initialize(data, left = nil, right = nil)
      @data = data
      @left = left
      @right = right
    end

    def <=>(other)
      data <=> other.data
    end
  end
end
