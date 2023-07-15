# frozen_string_literal: true

# This class represents a doubly linked list
class LinkedList
  attr_reader :head_sentinel, :tail_sentinel

  def initialize
    @head_sentinel = Node.new
    @tail_sentinel = Node.new
    head_sentinel.next_node = tail_sentinel
    tail_sentinel.prev_node = head_sentinel
  end

  def append(value)
    new_node = Node.new(value)
    prev_node = tail_sentinel.prev_node

    prev_node.next_node = new_node
    new_node.prev_node = prev_node
    new_node.next_node = tail_sentinel
    tail_sentinel.prev_node = new_node
  end

  def prepend(value)
    new_node = Node.new(value)
    next_node = head_sentinel.next_node

    next_node.prev_node = new_node
    new_node.next_node =  next_node
    new_node.prev_node = head_sentinel
    head_sentinel.next_node = new_node
  end
  # This class represents a node in the list
  class Node
    attr_accessor :value, :next_node, :prev_node

    def initialize(value = nil, next_node = nil, prev_node = nil)
      @value = value
      @next_node = next_node
      @prev_node = prev_node
    end
  end
end
