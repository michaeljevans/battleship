require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require 'pry'


class Celltest < MiniTest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end


end
