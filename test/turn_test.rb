require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'

class TurnTest < MiniTest::Test
  def test_it_exists
    turn = Turn.new

    assert_instance_of Turn, turn
  end

  def test_it_creates_cpu_board_correctly
    turn = Turn.new
    cpu_cruiser = Ship.new("Cruiser", 3)
    cpu_submarine = Ship.new("Submarine", 2)
    turn.cpu_placement(cpu_cruiser, cpu_submarine)

    assert_instance_of Board, turn.cpu_board
    assert_equal 16, turn.cpu_board.cells.keys.count
  end

  def test_cpu_ships_are_placed
    turn = Turn.new
    cpu_cruiser = Ship.new("Cruiser", 3)
    cpu_submarine = Ship.new("Submarine", 2)

    turn.cpu_placement(cpu_cruiser, cpu_submarine)

    ships_in = turn.cpu_board.cells.keys.map do |coord|
      !turn.cpu_board.cells[coord].empty?
    end

    # Tests that there are 5 cells occupied by a ship object
    assert_equal 5, ships_in.count(true)
    # And 11 cells are unoccupied
    assert_equal 11, ships_in.count(false)
  end
end
