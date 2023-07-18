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

  def insert(value)
    root.insert(value)
  end

  def remove(value)
    root.remove(value)
  end

  def find(value)
    root.find(value)
  end

  def level_order
    root.level_order
  end

  def inorder
    root.inorder
  end

  def preorder
    root.preorder
  end

  def postorder
    root.postorder
  end

  def height(node = root)
    node.height
  end

  def depth(to)
    root.depth(to)
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

    def deconstruct_keys(*)
      { data: data, left: left, right: right }
    end

    def insert(value)
      if value < data
        left&.insert(value) || self.left = Node.new(value)
      elsif value > data
        right&.insert(value) || self.right = Node.new(value)
      end
      self
    end

    def remove(value)
      case self
      in { left: { data: ^value, left: nil, right: nil } }
        self.left = nil

      in { right: { data: ^value, left: nil, right: nil } }
        self.right = nil

      in { left: { data: ^value, left: node, right: nil } }
        self.left = node

      in { left: { data: ^value, left: nil, right: node } }
        self.left = node

      in { right: { data: ^value, left: node, right: nil } }
        self.right = node

      in { right: { data: ^value, left: nil, right: node } }
        self.right = node

      in { data: ^value, left:, right: }
        replacing_node = inorder_successor
        remove(replacing_node.data)
        self.data = replacing_node.data

      in { data:, left:, right: }
        if value < data
          left&.remove(value)
        elsif value > data
          right&.remove(value)
        end
      end
      self
    end

    def find(value)
      if value < data
        left&.find(value)
      elsif value > data
        right&.find(value)
      else
        self
      end
    end

    def level_order
      values = []
      queue = [self]
      until queue.empty?
        node = queue.shift
        block_given? ? (yield node) : values.push(node.data)
        queue.push(node.left) unless node.left.nil?
        queue.push(node.right) unless node.right.nil?
      end
      values
    end

    def inorder(values = [])
      left&.inorder(values)

      values.push(data)
      yield self if block_given?

      right&.inorder(values)

      values
    end

    def preorder(values = [])
      values.push(data)
      yield self if block_given?

      left&.preorder(values)
      right&.preorder(values)

      values
    end

    def postorder(values = [])
      left&.postorder(values)
      right&.postorder(values)

      values.push(data)
      yield self if block_given?

      values
    end

    def leaf?
      left.nil? && right.nil?
    end

    def height
      if left.nil? && right.nil?
        0
      elsif left.nil?
        1 + right.height
      elsif right.nil?
        1 + left.height
      else
        1 + [right.height, left.height].max
      end
    end

    def depth(to, current_depth = 0)
      if equal?(to)
        current_depth
      else
        left&.depth(to, current_depth + 1) || right&.depth(to, current_depth + 1)
      end
    end

    private

    def inorder_successor
      if right.nil?
        # TODO
      else
        curr_node = right
        curr_node = curr_node.left until curr_node.left.nil?
        curr_node
      end
    end
  end
end
