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
            array.append(item) unless array.include?(item)
        end

        mid = ((array.length)/2).round()
        root = Node.new(array[mid])

        balance_left(array.slice(0, mid), root)
        balance_right(array.slice(mid, array.length), root)

        return root
    end
    
    def balance_left(array, node)
        mid = (array.length/2).round

        node.left = Node.new(array[mid])
        
        case array.length  
        when 3
          node.left.left = Node.new(array[0])  
          node.left.right = Node.new(array[2])  
        when 2
          node.left.left = Node.new(array[0])  
        else
          balance_left(array.slice(0, mid), node.left)  
          balance_right(array.slice(mid, array.length), node.left)  
        end  
    end

    def balance_right(array, node)
        mid = (array.length/2).round

        node.right = Node.new(array[mid])
        
        case array.length  
        when 3
            node.right.left = Node.new(array[0])
            node.right.right = Node.new(array[2])
        when 2
            node.right.left = Node.new(array[0])
        else
            balance_left(array.slice(0, mid), node.right)
            balance_right(array.slice(mid, array.length), node.right)
        end
    end

end