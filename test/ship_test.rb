require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < MiniTest::Test
  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
  end

  def test_hit_subtracts_health_from_ship
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 2, cruiser.hit
    assert_equal 1, cruiser.hit
    assert_equal 0, cruiser.hit
    assert_equal 0, cruiser.hit
  end

  def test_has_it_sunk
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, cruiser.sunk?

    cruiser.hit

    assert_equal false, cruiser.sunk?

    cruiser.hit

    assert_equal false, cruiser.sunk?

    cruiser.hit

    assert_equal true, cruiser.sunk?

    cruiser.hit

    assert_equal true, cruiser.sunk?
  end
end
