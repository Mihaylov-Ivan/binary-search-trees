require_relative './lib/tree.rb'

def run(array)
    tree = Tree.new(array)

    display_tree_and_info(tree)

    puts "Inserting 40"
    tree.insert(40)
    display_tree_and_info(tree)

    puts "Inserting 6, 17 and 46"
    tree.insert(6)
    tree.insert(17)
    tree.insert(46)
    display_tree_and_info(tree)

    puts "Deleting 46"
    tree.delete(46)
    display_tree_and_info(tree)
    
    puts "Deleting 8"
    tree.delete(8)
    display_tree_and_info(tree)

    puts "Deleting 29"
    tree.delete(29)
    display_tree_and_info(tree)
end

def display_tree_and_info(tree)
    tree.pretty_print
    if tree.balanced?
        puts "Tree is balanced"
        tree.display_traversal_orders
    else
        puts "Tree is not balanced. Rebalancing:"
        tree.rebalance
        tree.pretty_print
        tree.display_traversal_orders
    end
    display_nodes_info(tree)
end

def display_nodes_info(tree)
    node_15 = tree.find(15)
    node_13 = tree.find(13)
    puts "Node with value 15 has left node value of #{node_15.left.nil? ? "nil" : node_15.left.value} and right node value of #{node_15.right.nil? ? "nil" : node_15.right.value}"
    puts "Node with value 13 has left node value of #{node_13.left.nil? ? "nil" : node_13.left.value} and right node value of #{node_13.right.nil? ? "nil" : node_13.right.value}"
    puts "The height of node 3 is #{tree.height(3)}"
    puts "The height of node 37 is #{tree.height(37)}"
    puts "The height of node 36 is #{tree.height(36)}"
    puts "The height of node 15 is #{tree.height(15)}"
    puts "The height of node 25 is #{tree.height(25)}"
    puts "The height of node 11 is #{tree.height(11)}"
end

run([3, 4, 25, 1, 37, 13, 8, 21, 9, 29, 36, 15, 1, 11, 33, 2, 7])