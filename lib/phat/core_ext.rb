class TrueClass
  def to_phat options=nil; self; end
end
class FalseClass
  def to_phat options=nil; self; end
end
class NilClass
  def to_phat options=nil; self; end
end
class String
  def to_phat options=nil; self; end
end
class Numeric
  def to_phat options=nil; self; end
end

module Enumerable
  def to_phat options={}, &block
    map { |i| i.to_phat options, &block }
  end
end

class Hash
  def to_phat options={}, &block
    ret = {}
    each do |k,v|
      ret[k] = v.to_phat options, &block
    end
    ret
  end

  def compact
    reject { |k,v| !v }
  end
end
