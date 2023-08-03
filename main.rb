require_relative './lib/tree.rb'

def run(array)
    tree = Tree.new(array)
    # puts tree.root.inspect
    tree.pretty_print()
end

run([4, 25, 1, 13, 21, 9, 29, 36, 15, 1, 11, 33, 2, 7])

#[1, 2, 4, 7, 9, 11, 13, 15, 21, 25, 29, 33, 36]  v = 13

#[1, 2, 4, 7, 9, 11]  v = 7
#[15, 21, 25, 29, 33, 36]  v = 29

#[1, 2, 4]  v = 2
#[9, 11]
#[15, 21, 25]  v = 21
#[33, 36]

#[1, 4]
#[9, 11]
#[15, 25]
#[33, 36]