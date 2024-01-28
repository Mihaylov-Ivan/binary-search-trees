require_relative './node.rb'

class Tree

    attr_accessor :root

    def initialize(array)
        @array = array.sort!
        @root = build_tree(@array)
    end

    def insert(value, node=root)
        if value > node.value
            if node.right == nil
                return node.right = Node.new(value)
            end
            insert(value, node.right)
        end
        if value < node.value
            if node.left == nil
                return node.left = Node.new(value)
            end
            insert(value, node.left)
        end
    end

    def delete(value, node = root)
        return node if node.nil?

        if value < node.value
          node.left = delete(value, node.left)
        elsif value > node.value
          node.right = delete(value, node.right)
        else
          # if node has one or no child
          return node.right if node.left.nil?
          return node.left if node.right.nil?

          # if node has two children
          leftmost_node = get_leftmost(node.right)
          node.value = leftmost_node.value
          node.right = delete(leftmost_node.value, node.right)
        end
        node
    end

    def display_traversal_orders
        puts "Level order traversal:\n#{level_order().join(" ")}"
        puts "Inorder traversal:\n#{inorder().join(" ")}"
        puts "Pre order traversal:\n#{pre_order().join(" ")}"
        puts "Post order traversal:\n#{post_order().join(" ")}"
    end

    def find(value, node=root)
        return node if node.value==value

        value < node.value ? find(value, node.left) : find(value, node.right)
    end

    def height(value, left_height=0, right_height=0)
        node=find(value)
        return 0 if node.left.nil? && node.right.nil?

        left_height = 1 + height(node.left.value) unless node.left.nil?
        right_height = 1 +  height(node.right.value) unless node.right.nil?

        left_height > right_height ? (return left_height) : (return right_height)
    end

    def balanced?(node=root)
        return true if node.nil?

        node.left.nil? ? height_left=0 : height_left = height(node.left.value)
        node.right.nil? ? height_right=0 : height_right = height(node.right.value)

        return true if (height_left-height_right).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    end

    def rebalance
        self.root = build_tree(inorder())
    end

    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    private

    def build_tree(array_input)
        return Node.new(array_input[0]) if array_input.length==1

        array = []
        array_input.each do |item|
            array.append(item) unless array.include?(item)
        end

        if array.length==2 then
            root = Node.new(array[1])
            root.left = Node.new(array[0])

            return root
        end

        mid = (array.length/2).floor
        array.length%2 == 0 ? mid=mid-1 : mid=mid
        root = Node.new(array[mid])

        balance_tree(array, root, true, mid)
        balance_tree(array, root, false, mid)

        return root
    end

    def balance_tree(array, node, left, mid)
        left ? array=array[0..(mid-1)] : array=array[(mid+1)..array.length]
        mid = (array.length/2).floor
        array.length%2 == 0 ? mid-=1 : mid=mid

        current_node = Node.new(array[mid])
        left ? node.left = current_node : node.right = current_node

        case array.length
        when 3
            current_node.left = Node.new(array[0])
            current_node.right = Node.new(array[2])
        when 2
            current_node.right = Node.new(array[1])
        when 1
            #do nothing
        else
            balance_tree(array, current_node, true, mid)
            balance_tree(array, current_node, false, mid)
        end
    end

    def level_order(traversal = [], queue=[], node = root)
        traversal<<node.value
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?

        return traversal if queue.empty?

        level_order(traversal, queue, queue.shift)
    end

    def pre_order(traversal = [], node = root)
        traversal<<node.value
        pre_order(traversal, node.left) unless node.left.nil?
        pre_order(traversal, node.right) unless node.right.nil?

        return traversal
    end

    def inorder(traversal = [], node = root)
        traversal = inorder(traversal, node.left) unless node.left.nil?
        traversal.append(node.value)
        traversal = inorder(traversal, node.right) unless node.right.nil?

        return traversal
    end

    def post_order(traversal = [], node = root)
        traversal = post_order(traversal, node.left) unless node.left.nil?
        traversal = post_order(traversal, node.right) unless node.right.nil?
        traversal<<node.value

        return traversal
    end

    def get_leftmost(node)
        node = node.left until node.left.nil?

        node
    end
end
