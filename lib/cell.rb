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

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if !empty?
     @ship.hit
    end
  end

  def render(ship_exists = false)
    if fired_upon? == false && ship_exists == false
      "."
    elsif ship_exists == true
      "S"
    elsif fired_upon? == true && !empty? && @ship.health == 0
      "X"
    elsif fired_upon? == true && !empty?
      "H"
    elsif fired_upon? == true && empty?
      "M"
    end
  end
end
