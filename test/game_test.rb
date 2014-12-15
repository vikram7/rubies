require 'test_helper'

class Game < MiniTest::Unit::TestCase

  def setup
    @input = FakeInput.new([])
    @game = Rubies::Game.new({in: @input})
  end

  def test_display_splash
    @input << "\n" #add enter to the input

    @game.display_splash
    assert_equal 0, @input.size
  end

  def test_display_score
    #@game.display_score
  end

  def test_scoreboard
    #@game.scoreboard(10, 10)
  end

  def test_generate_data_structure
    #@game.generate_data_structure
  end

  def test_play_round
    #@game.play_round
  end

  def test_game
    #@game.game
  end

end