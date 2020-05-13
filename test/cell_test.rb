require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require 'pry'


class Celltest < MiniTest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_it_has_readable_attributes
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
    assert_nil cell.ship
  end

  def test_it_is_empty?
    cell = Cell.new("B4")
    assert cell.empty?
  end

  def test_it_places_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    assert cell.empty?
    cell.place_ship(cruiser)
    refute cell.empty?
  end

  def test_it_is_fired_upon?
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)
    refute cell.fired_upon?
    cell.fire_upon
    assert cell.fired_upon?
  end

  def test_it_can_fire
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)
    assert_equal 2, cell.fire_upon
    assert_equal 1, cell.fire_upon
    assert cell.fired_upon?
  end

end
