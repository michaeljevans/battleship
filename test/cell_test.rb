require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

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

    assert_equal true, cell.empty?
  end

  def test_it_places_ship
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
    cell.place_ship(cruiser)
    assert_equal false, cell.empty?
  end

  def test_it_is_fired_upon?
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
    cell.fire_upon
    assert_equal true, cell.fired_upon?
  end

  def test_it_can_fire
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)

    assert_equal 2, cell.fire_upon
    assert_equal true, cell.fired_upon?
  end

  def test_it_renders_correctly
    cell1 = Cell.new("B4")

    assert_equal ".", cell1.render
    cell1.fire_upon
    assert_equal "M", cell1.render

    cell2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell2.place_ship(cruiser)

    assert_equal ".", cell2.render
    assert_equal "S", cell2.render(true)
    cell2.fire_upon
    assert_equal "H", cell2.render
    assert_equal false, cruiser.sunk?
    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell2.render
  end
end
