require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < MiniTest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
    assert_equal 16, board.cells.count
  end

  def test_it_has_valid_coordinates
    board = Board.new
    board.cells
    assert board.valid_coordinates?("A1")
    refute board.valid_coordinates?("A6")
    refute board.valid_coordinates?("D11")
  end
end
