require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'
require 'pry'

class TurnTest < MiniTest::Test
  def test_it_exists
    turn = Turn.new
    assert_instance_of Turn, turn
  end

  def test_it_creates_cpu_board
    turn = Turn.new
    turn.cpu_placement
    binding.pry
    turn.cpu_board.render
  end


end
