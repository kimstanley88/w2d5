require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    string = "1"
    self.each_with_index do |value, index|
      string << value.hash.to_s if value.is_a? Array
      string << value.to_s
      string << index.to_s
    end
    string.to_i

  end
end

class String
  def hash
    string = ""
    self.each_char.with_index do |char, index|
      string << char.ord.to_s
      string << index.to_s
    end
    string.to_i
  end
end

class Hash
  def hash
    sorted_hash = self.sort
    string = ""
    idx = 0
    sorted_hash.each do |key, value|
      string << key.to_s.ord.to_s
      string << value.hash.to_s
      string << idx.to_s
      idx += 1
    end
    string.to_i
  end
end
