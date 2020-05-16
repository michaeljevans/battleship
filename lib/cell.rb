class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship
    @fired_upon = false
  end

  def empty?
    ship.nil?
  end

  def place_ship(ship_type)
    @ship = ship_type
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !empty? && @fired_upon == false
      @fired_upon = true
      @ship.hit
    else
      @fired_upon = true
    end
  end

  def render(show_ships=false)
    if fired_upon? == false && show_ships == true && !empty?
      "S"
    elsif fired_upon? == true && !empty? && @ship.health == 0
      "X"
    elsif fired_upon? == true && !empty?
      "H"
    elsif fired_upon? == true && empty?
      "M"
    elsif fired_upon? == false
      "."
    end
  end
end
