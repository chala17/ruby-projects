# frozen-string-literal: true

# creates the structure for holding all the nodes and functionality to manipulate it 
class LinkedList
  def initialize(head)
    @head = head
    @count = 1
  end

  def traverse_until(value)
    current = @head
    current = current.next_node until current.next_node == value
    current
  end

  def append(value)
    last_node = traverse_until(nil)
    last_node.next_node = Node.new(value)
    @count += 1
  end

  def prepend(value)
    @head = Node.new(value, @head)
    @count += 1
  end

  def size
    @count
  end

  def head
    @head
  end

  def tail
    traverse_until(nil)
  end

  # zero based index
  def at(index)
    return nil if index > @count

    current = @head
    current_index = 0
    until index == current_index
      current = current.next_node
      current_index += 1
    end
    current
  end

  def pop
    last = traverse_until(traverse_until(nil))
    last.next_node = nil
    @count -= 1
  end

  def contains?(value)
    current = @head
    until current.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def find(value)
    current = @head
    current_index = 0
    until current.value == value
      current = current.next_node
      current_index += 1
      return nil if current.next_node.nil? && current.value != value
    end
    current_index
  end

  def to_s
    current = @head
    until current.nil?
      print "( #{current.value} ) -> "
      current = current.next_node
    end
    puts 'nil'
  end

  def insert_at(value, index)
    old_node = at(index)
    traverse_until(old_node).next_node = Node.new(value, old_node)
    @count += 1
  end

  def remove_at(index)
    old_node = at(index)
    traverse_until(old_node).next_node = old_node.next_node
    @count -= 1
  end
end

# creates Nodes that are the elements of the linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def adjust_value(value)
    @value = value
  end
end
