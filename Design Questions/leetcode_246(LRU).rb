class LRUCache
  attr_accessor :cache

  def initialize(capacity)
    @capacity = capacity
    @cache = {}                     # HashMap: key -> Node for O(1) access

    # Dummy head and tail nodes to simplify insert/delete logic
    @head = Node.new(nil, nil)      # Most recently used will be next to head
    @tail = Node.new(nil, nil)      # Least recently used will be before tail

    @head.next = @tail
    @tail.prev = @head
  end

  # Returns the value for the key if exists, else -1.
  # Also moves the accessed node to the head (most recently used).
  def get(key)
    if @cache[key]
      node = @cache[key]

      # Since it's accessed, move it to front (MRU)
      remove_node(node)
      insert_at_head(node)

      return node.value
    else
      return -1
    end
  end

  # Inserts or updates the key-value pair.
  # New or updated node becomes the most recently used.
  # If full, evict least recently used node (node before @tail)
  def put(key, value)
    if @cache[key]
      # Key already exists → update value and move to head
      node = @cache[key]
      node.value = value

      remove_node(node)
      insert_at_head(node)

    else
      # New key
      if @cache.size < @capacity
        # There is space → just insert
        node = Node.new(key, value)
        @cache[key] = node
        insert_at_head(node)
      else
        # Cache is full → remove LRU node (node before tail)
        deleted_node = @tail.prev
        remove_node(deleted_node)
        @cache.delete(deleted_node.key)

        # Insert new node as MRU
        node = Node.new(key, value)
        @cache[key] = node
        insert_at_head(node)
      end
    end
  end

  # Removes a node from the doubly linked list
  def remove_node(node)
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  # Inserts a node right after @head (making it MRU)
  def insert_at_head(node)
    node.prev = @head
    node.next = @head.next

    @head.next.prev = node
    @head.next = node
  end

  # Debug method to print cache order from most recent to least recent
  def print_cache
    cur = @head.next
    while cur != @tail           # Stop before dummy tail
      print "#{cur.value} -> "
      cur = cur.next
    end
    puts "END"
  end

end

# Node class for doubly linked list
class Node
  attr_accessor :key, :value, :prev, :next

  def initialize(key, value)
    @key = key
    @value = value
    @prev = nil
    @next = nil
  end
end