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
