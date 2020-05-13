class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship
    @fired_upon = false
  end

  def empty?
    if ship.nil?
      true
    else
      false
    end
  end

  def place_ship(ship_type)
    @ship = ship_type
  end

  # Method needs to be given functionality
  def fired_upon?
    @fired_upon
  end

  def fire_upon(ship)
    @fired_upon = true
    ship.hit
  end
end
