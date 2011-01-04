module Phat
  module ActiveRecord
    def to_phat options={}
      keys = if options[:only]
        Array(options[:only])
      elsif options[:except]
        attributes.keys - Array(options[:except])
      else
        attributes.keys
      end + Array(options[:also])

      ret = {}
      keys.each { |key| ret[key] = send key }

      if options[:refs]
        options[:refs].each do |i,roptions|
          obj = send i
          obj = roptions[:transform].(obj) if roptions[:transform]
          ret[i] = obj.to_phat(roptions)
        end
      end

      if options[:merge]
        options[:merge].each do |k,v|
          catch :omit do
            v = v.(self) if v.is_a? Proc
            ret[k] = v
          end
        end
      end

      ret
    end
  end
end
