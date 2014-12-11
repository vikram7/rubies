class RandomArray < Array
  def initialize
    @ds = Array.new
  end

  def mini_array
    (-1_000..1_000).sort_by { rand }.sample 3
  end

  def nesting_array
    rand(1..3).times do
      @ds << mini_array
    end
    @ds.each do |array|
      array << mini_array
    end
    @ds
  end

  def generate
    depth = rand(0..3)
    nesting_array.flatten(depth)
  end
end
