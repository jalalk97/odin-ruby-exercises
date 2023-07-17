# frozen_string_literal: true

# This class represents a doubly linked list
class LinkedList
  include Enumerable

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

  def each
    return to_enum unless block_given?

    curr_node = head_sentinel.next_node
    until curr_node.equal?(tail_sentinel)
      yield curr_node
      curr_node = curr_node.next_node
    end
    self
  end

  def size
    count
  end

  def head
    head_sentinel.next_node.equal?(tail_sentinel) ? nil : head_sentinel.next_node
  end

  def tail
    tail_sentinel.prev_node.equal?(head_sentinel) ? nil : tail_sentinel.prev_node
  end

  def at(index)
    node_at(index)&.value
  end

  def pop
    return nil unless size.positive?

    last_node = tail
    last_node.prev_node.next_node = tail_sentinel
    tail_sentinel.prev_node = last_node.prev_node
    last_node.value
  end

  def contains?(value)
    !!(find { |node| node.value == value })
  end

  def find_index_of(value)
    find_index { |element| element.value == value }
  end

  def insert_at(value, index)
    case value
    when 0 then prepend(value)
    when size then append(value)
    else
      node = node_at(index)
      return value unless node

      new_node = Node.new(value)

      new_node.prev_node = node.prev_node
      node.prev_node.next_node = new_node
      new_node.next_node = node
      node.prev_node = new_node
    end
    value
  end

  def remove_at(index)
    node = node_at(index)
    return nil if node.nil?

    node.prev_node.next_node = node.next_node
    node.next_node.prev_node = node.prev_node
    node.value
  end

  def to_s
    "nil <- #{each.to_a.join(" <-> ")} -> nil"
  end

  private

  def node_at(index)
    find.with_index { |_, i| i == index }
  end

  # This class represents a node in the list
  class Node
    attr_accessor :value, :next_node, :prev_node

    def initialize(value = nil, next_node = nil, prev_node = nil)
      @value = value
      @next_node = next_node
      @prev_node = prev_node
    end

    def to_s
      value.nil? ? "nil" : "( #{value} )"
    end
  end
end
