require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
  end

  def add(key)
    if @map.include?(key)
      value = @map[key].val
      @store.delete(key)
      @store.insert(key, value)
      @map[key] = @store.tail
    else
      value = calc!(key)
      @map.set(key, value)
    end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
  end
end

cache = LRUCache.new
cache.add[k, v]
