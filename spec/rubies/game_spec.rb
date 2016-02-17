require 'spec_helper'

module Rubies
  describe Game do
    before do
      @input = FakeInput.new([])
      @game = Rubies::Game.new({ in: @input })
    end

    it "#initializes a game correctly" do
      expect(@game.num_right).to eq(0)
      expect(@game.num_wrong).to eq(0)
      expect(@game.playing).to eq(true)
    end

    it "#generate_data_structure returns a data structure and target" do
      output = @game.generate_data_structure
      expect(is_hash_my_hash_or_array(output.first)).to eq(true)
      expect(is_hash_or_fixnum_or_string(output.last)).to eq(true)
    end
  end
end

def is_hash_my_hash_or_array(data_structure)
  klass = data_structure.class
  [Hash, Rubies::MyHash, Array].any?(&klass.method(:==))
end

def is_hash_or_fixnum_or_string(value)
  klass = value.class
  [Hash, Fixnum, String].any?(&klass.method(:==))
end
