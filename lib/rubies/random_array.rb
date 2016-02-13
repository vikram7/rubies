module Rubies
  class RandomArray < ::Array
    def mini_array
      (-1_000..1_000).sort_by { rand }.sample 3
    end

    def nesting_array
      result = []
      rand(1..3).times { result << mini_array }
      result.each { |array| array << mini_array }
    end

    def generate
      depth = rand(0..3)
      nesting_array.flatten(depth)
    end
  end
end
