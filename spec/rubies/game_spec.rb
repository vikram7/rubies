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
      rds = @game.generate_data_structure
      hra = [Hash, Rubies::MyHash, Array]
      hfs = [Hash, Fixnum, String]
      expect(is_one_of_these_things_like_the_other?(hra, rds[0])).to eq(true)
      expect(is_one_of_these_things_like_the_other?(hfs, rds[1])).to eq(true)
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

    it "#itswrong increments @num_wrong by one" do
      expect(@game.num_wrong).to eq(0)
      @game.itswrong("anything")
      expect(@game.num_wrong).to eq(1)
    end

    it "#itsright increments @num_right by one" do
      expect(@game.num_right).to eq(0)
      @game.itsright
      expect(@game.num_right).to eq(1)
    end

    it "#check_for_cheaters returns true if input is bad" do
      expect(@game.send(:check_for_cheaters, "check_answer")).to eq(true)
    end

    it "#check_for_cheaters returns false if input is not bad" do
      expect(@game.send(:check_for_cheaters, "current[0]")).to eq(false)
    end
  end
end

def is_one_of_these_things_like_the_other?(class_array, other)
  klass = other.class
  class_array.any?(&klass.method(:==))
end
