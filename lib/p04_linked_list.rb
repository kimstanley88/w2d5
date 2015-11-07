
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @prev= key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.key.nil?
  end

  def get(key)
    current_link = @head
    until current_link.key == key
      return nil if current_link.next.nil?
      current_link = current_link.next
    end
    current_link.val
  end

  def include?(key)
    current_link = @head
    until current_link.key == key
      return false if current_link.next.nil?
      current_link = current_link.next
    end
    true
  end

  def insert(key, val)
    if empty?
      @head.key = key
      @head.val = val
    else
      link = Link.new(key, val)
      @tail.next = link
      link.prev = @tail
      @tail = link
    end
  end

  def remove(key)
    current_link = @head
    previous_link = nil
    until current_link.key == key
      return nil if current_link.next.nil?
      previous_link = current_link
      current_link = current_link.next
    end
    if previous_link.nil?
      current_link.key = nil
      current_link.val = nil
    else
      previous_link.next = current_link.next
      current_link.next.prev = previous_link
    end

  end

  def each(&prc)
    current_link = @head
    until current_link == nil
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
