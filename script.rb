# frozen_string_literal: true

# New Node class
class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end

# LinkedList Class
class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def tail
    current_node = @head

    current_node = current_node.next_node while current_node.next_node

    current_node
  end

  def size
    count = 0
    current_node = @head

    while current_node
      current_node = current_node.next_node
      count += 1
    end

    count
  end

  def append(value)
    new_node = Node.new(value, nil)

    if @head.nil?
      @head = new_node
    else
      current_node = @head

      current_node = current_node.next_node while current_node.next_node

      current_node.next_node = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value, nil)

    if @head.nil?
      @head = new_node
    else
      current_node = @head
      @head = new_node
      new_node.next_node = current_node
    end
  end

  def at(index)
    count = 0

    current_node = @head

    while current_node
      return current_node if count == index

      current_node = current_node.next_node
      count += 1
    end
  end

  def pop
    current_node = @head

    if size <= 1
      @head = nil
      return current_node
    end

    current_node = current_node.next_node while current_node.next_node.next_node

    removed_node = current_node.next_node
    current_node.next_node = nil

    removed_node
  end

  def contains?(value)
    current_node = @head

    while current_node
      return true if current_node.value == value

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_node = @head
    count = 0

    while current_node
      return count if current_node.value == value

      count += 1
      current_node = current_node.next_node
    end
  end

  def to_s
    return_value = []

    current_node = @head

    while current_node
      return_value << "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    "#{return_value.join}nil"
  end

  def insert_at(value, index)
    new_node = Node.new(value, nil)

    return append(value) if size < 1 || index >= size

    return prepend(value) if index < 1

    before_node = at(index - 1)
    after_node = at(index)

    before_node.next_node = new_node
    new_node.next_node = after_node
    new_node
  end

  def remove_at(index)
    if index.zero?
      @head = @head.next_node
    elsif index == size - 1
      pop
    elsif index.positive? && index < size - 1
      before_node = at(index - 1)
      after_node = at(index + 1)

      before_node.next_node = after_node
    else
      raise ArgumentError, "Invalid index: #{index}. The index must be between 0 and #{size - 1}."
    end
  end
end

list = LinkedList.new
list.append('a')
list.append('b')
list.append('c')
list.append('d')
list.append('e')
p list.find('e')
list.remove_at 3
p list.to_s
