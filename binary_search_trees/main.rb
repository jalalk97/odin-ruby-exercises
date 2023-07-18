# frozen_string_literal: true

require_relative "./lib/bst"

def init_tree
  random_numbers = (Array.new(15) { rand(1..100) })
  puts "Initializing new BST from random numbers: #{random_numbers}"
  Tree.new(random_numbers)
end

def print_tree_traversals(tree)
  puts "Traversals:"
  puts "Level order: #{tree.level_order}"
  puts "Pre-order: #{tree.preorder}"
  puts "Post-order: #{tree.postorder}"
  puts "In-order: #{tree.inorder}\n\n"
end

def print_tree_status(tree)
  tree.pretty_print
  puts "Is the tree balanced?: #{tree.balanced?}\n\n"
end

def add_values_to_tree(tree, amount = 10)
  print "Inserting:"
  amount.times do
    random_number = rand(101..200)
    print " #{random_number}"
    tree.insert(random_number)
  end
  puts
end

def rebalance_tree(tree)
  puts "Rebalancing..."
  tree.rebalance
end

def main
  tree = init_tree
  print_tree_status(tree)
  print_tree_traversals(tree)

  add_values_to_tree(tree)
  print_tree_status(tree)

  rebalance_tree(tree)

  print_tree_status(tree)
  print_tree_traversals(tree)
end

main
