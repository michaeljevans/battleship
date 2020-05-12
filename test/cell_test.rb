require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require 'pry'


class Celltest < MiniTest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_it_has_readable_attributes
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
  end

end
