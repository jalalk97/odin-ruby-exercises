# frozen_string_literal: true

# This class represents a doubly linked list
class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    head.next_node = tail
    tail.prev_node = head
  end

  def append(value)
    new_node = Node.new(value)
    prev_node = tail.prev_node

    prev_node.next_node = new_node
    new_node.prev_node = prev_node
    new_node.next_node = tail
    tail.prev_node = new_node
  end

  def prepend(value)
    new_node = Node.new(value)
    next_node = head.next_node

    next_node.prev_node = new_node
    new_node.next_node =  next_node
    new_node.prev_node = head
    head.next_node = new_node
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
