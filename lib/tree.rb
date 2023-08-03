require_relative './node.rb'

class Tree

    attr_reader :root

    def initialize(array)
        @array = array.sort!
        @root = build_tree(@array)
    end

    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    private

    def build_tree(array_input)
        array = []
        array_input.each do |item|
            array.append(item) if !array.include?(item)
        end

        mid = ((array.length)/2).round()
        root = Node.new(array[mid])

        balance_left(array[0..(mid-1)], root)
        balance_right(array[(mid+1)..array.length], root)

        return root
    end
    
    def balance_left(array, node)
        mid = ((array.length())/2).round()

        node.left = Node.new(array[mid])
        if array.length() >3
            balance_left(array[0..(mid-1)], node.left)
            balance_right(array[(mid+1)..array.length], node.left)
        elsif array.length() == 3
            node.left.left = Node.new(array[0])
            node.left.right = Node.new(array[2])
        else
            node.left.left = Node.new(array[0])
        end
    end

    def balance_right(array, node)
        mid = ((array.length())/2).round()

        node.right = Node.new(array[mid])
        if array.length() >3
            balance_left(array[0..(mid-1)], node.right)
            balance_right(array[(mid+1)..array.length], node.right)
        elsif array.length() == 3
            node.right.left = Node.new(array[0])
            node.right.right = Node.new(array[2])
        else
            node.right.left = Node.new(array[0])
        end
    end
end