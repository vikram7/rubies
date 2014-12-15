require 'test_helper'

class RandomArray < MiniTest::Unit::TestCase

  def test_initialize
    @array = Rubies::RandomArray.new
  end

  def test_generate
    Rubies::RandomArray.new.generate
  end


end