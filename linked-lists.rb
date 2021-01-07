require 'byebug';

class LinkedList
  # Linked List or something
  attr_accessor :array

  def initialize
    @array = []
  end

  def append(value=nil, next_node=nil)
    @array.each do |el|
      el.next_node = @array.length if el.next_node.nil?
    end
    @array << Node.new(value, next_node)
  end

  def prepend(value=nil, next_node=nil)
    @array.each do |el|
      el.next_node += 1 if !el.next_node.nil?
    end
    @array << Node.new(value, 1)
  end

  def size
    return @array.length
  end

  def head
    @array.find { |el| el.next_node == 1 }
  end

  def tail
    @array.find { |el| el.next_node.nil? }
  end

  def at(idx)
    if idx == @array.length - 1
      @array.find { |el| el.next_node.nil? }
    else
      @array.each do |el|
        return el if el.next_node == idx + 1
      end
    end
  end

  def pop
    @array = @array.reject { |el| el.next_node.nil? }
    @array.each do |el|
      el.next_node = nil if el.next_node == @array.length
    end
  end

  def contains?(value)
    @array.any? { |el| el.val == value }
  end

  def find(value)
    @array.find { |el| el.val == value }
    nil
  end

  def to_s
    idx = 0
    while idx < @array.length
      node = self.at(idx)
      print node.val
      print ' -> ' if !node.next_node.nil?
      idx += 1
    end
    puts
  end

  def insert_at(value, index)
    @array.each do |el|
      el.next_node += 1 if !el.next_node.nil? && el.next_node >= index
    end

    if index >= @array.length
      idx = nil
      self.append(value,idx)
    else
      idx = index
      @array << Node.new(value, idx)
    end
  end

  def remove_at(index)
    if index < @array.length
      if index == @array.length - 1
        self.pop
      else
        el = @array.find { |el| el.next_node == index + 1 }
        @array.delete(el)
        @array.each do |el|
          el.next_node -= 1 if !el.next_node.nil? && el.next_node > index
        end
      end
    end
  end
end

class Node
  # Node class
  attr_accessor :val, :next_node

  def initialize(val, next_node)
    value(val, next_node)
  end

  def value(val=nil, next_node=nil)
    @val = val
    @next_node = next_node
  end
end

test = LinkedList.new
test.append('world')
test.append('!')
test.append('ipsum')
test.prepend('hello')
test.insert_at('lorem', 6)
test.to_s
# test.remove_at(2)
byebug
test.to_s

puts test.size
puts test.head
puts test.tail
puts test.at(1)