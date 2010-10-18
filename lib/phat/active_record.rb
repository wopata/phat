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
          if ref = self.class.reflections[i]
            ret[i] = send(i).to_phat(roptions)
          end
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
