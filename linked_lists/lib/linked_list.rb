# frozen_string_literal: true

# This class represents a doubly linked list
class LinkedList
  def initialize; end

  # This class represents a node in the list
  class Node
    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end
  end
end
