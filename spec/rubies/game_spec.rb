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
      expect(is_one_of_these_things_like_the_other?([Hash, Rubies::MyHash, Array], output.first)).to eq(true)
      expect(is_one_of_these_things_like_the_other?([Hash, Fixnum, String], output.last)).to eq(true)
    end

    it "#gameover? returns false if @playing is true" do
      @game.playing = false
      is_gameover = @game.gameover?
      expect(is_gameover).to eq(true)
    end

    it "#gameover? returns true if @playing is false" do
      @game.playing = true
      is_gameover = @game.gameover?
      expect(is_gameover).to eq(false)
    end
  end
end

def is_one_of_these_things_like_the_other?(class_array, other)
  klass = other.class
  class_array.any?(&klass.method(:==))
end
