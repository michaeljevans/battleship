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

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
    assert_equal true, board.valid_coordinate?("c3")
  end

  def test_placement_invalid_if_coordinate_array_length_and_ship_length_are_different
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_placement_invalid_if_coordinate_array_elements_are_not_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_placement_invalid_if_coordinate_array_elements_are_diagonal
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A4", "B3", "C2"])
  end

  def test_valid_ship_placement
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
    assert_equal false, board.valid_placement?(cruiser, ["A5", "A6", "A7"])
    assert_equal false, board.valid_placement?(submarine, ["A4", "A5"])
  end

  def test_it_has_valid_placement?
    skip
    board = Board.new
    board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert board.valid_placement?(cruiser, ["A2","A3","A4"])
  end
end
