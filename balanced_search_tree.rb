# frozen-string-literal: true

class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end


end

class Tree

  attr_accessor :root

  def initialize(arr)
    @arr = arr.uniq.sort
    @root = build_tree(@arr, 0, @arr.length - 1)
  end

  def build_tree(arr, start, last)
    return nil if start > last

    mid = (start + last) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr, start, mid - 1)
    root.right = build_tree(arr, mid + 1, last)
    root
  end

  def insert(value, node=@root)
    return if value == node.data

    if value < node.data
      if node.left == nil
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    else
      if node.right == nil
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end

  def delete(value)
    
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

tree = Tree.new([1,2,3])
tree.pretty_print
puts
tree.insert(4)
tree.pretty_print
tree.insert(5)
tree.insert(6)
tree.insert(0)
tree.insert(1)
tree.pretty_print