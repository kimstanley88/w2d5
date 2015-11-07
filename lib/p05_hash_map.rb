require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    linked_list = @store[key.hash % num_buckets]
    linked_list.include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    linked_list = @store[key.hash % num_buckets]
    if linked_list.include?(key)
      linked_list.each do |link|
        link.val = val if link.key == key
      end
    else
      linked_list.insert(key, val)
    end
    @count += 1
  end

  def get(key)
    linked_list = @store[key.hash % num_buckets]
    linked_list.get(key)
  end

  def delete(key)
    linked_list = @store[key.hash % num_buckets]
    linked_list.remove(key)
    @count -= 1
  end

  def each(&prc)
    # debugger
    @store.each do |linked_list|
      next if linked_list.empty?
      linked_list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_bucket = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |bucket|
      next if bucket.empty?
      bucket.each do |link|
        new_bucket[link.key.hash % (num_buckets * 2)].insert(link.key, link.val)
      end
    end
    @store = new_bucket
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
