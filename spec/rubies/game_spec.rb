require 'spec_helper'

module Rubies
  describe Game do

    before do
      @input = FakeInput.new([])
      @game = Rubies::Game.new({in: @input})
    end

    it "displays splash" do
      @input << "\n" #add enter to the input

      @game.display_splash
      expect(@input.size).to eq(0)
    end

    it "displays score" do
      #@game.display_score
    end

    it "has scoreboard" do
      #@game.scoreboard(10, 10)
    end

  end
end
