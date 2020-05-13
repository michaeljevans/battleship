require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

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

  def test_it_has_valid_placement?
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.valid_placement?(cruiser, ["A2","A3","A4"])
  end
end
