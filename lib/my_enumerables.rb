module Enumerable
  # Your code goes here
  def my_each
    return self.to_enum unless block_given?
    if self.is_a?(Array)
      self.size.times {|index| yield self[index]}
      self
    else
      self.keys.size.times {|key_index| yield self.keys[key_index], self[self.keys[key_index]]} #applies for hash?
      self
    end
  end

  def my_each_with_index
    return self.to_enum unless block_given?
      if self.is_a?(Array)
        self.size.times {|index| yield self[index], index}
        self
      end
  end

  def my_select
    return self.to_enum unless block_given?
    output = self.is_a?(Hash) ? {} : []
    self.my_each do |ev|
      if yield ev
        self.is_a?(Hash) ? output.store(ev[0], ev[1]) : output << ev
      end
    end
    return output
  end

  def my_all?
    return true unless block_given?
    same = true
    self.my_each do |ev|
      if yield ev
      else
        same = false
      end
    end
    return same
  end

  def my_any?
    return true unless block_given?
    same = false
    self.my_each do |ev|
      if yield ev
        same = true
      end
    end
    return same
  end

  def my_none?
    return false unless block_given?
    unique = true
    self.my_each do |ev|
      if yield ev
        unique = false
      end
    end
    return unique
  end

  def my_count
    return self.length unless block_given?
    counter = 0
    self.my_each do |ev|
      if yield ev
        counter += 1
      end
    end
    return counter
  end

  def my_map
    return self.to_enum unless block_given?
    output = []
    my_each { |ev| output<< yield(ev)}
    return output
  end

  def my_inject(initial_value = 0, &block)
    leng = self.length
    for i in 0..(leng - 1)
      initial_value = yield(initial_value, self[i])
    end
    return initial_value
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  include Enumerable
  def initialize(arr)
    @arr = arr
  end
end

