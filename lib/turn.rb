class Turn

  attr_reader :cpu_placement,
              :player_placement,
              :cpu_board,
              :player_board

  def initialize()
    @cpu_placement
    @player_placement
    @cpu_board
    @player_board
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @cpu_intelligence_next_shot = ""

  end

  def play
    cpu_placement(@cpu_cruiser, @cpu_submarine)
    player_placement(@player_cruiser, @player_submarine)
    until (@cpu_cruiser.health == 0 && @cpu_submarine.health == 0) || (@player_cruiser.health == 0 && @player_submarine.health == 0)
      p "========== COMPUTER BOARD =========="
      print @cpu_board.render
      p "=========== PLAYER BOARD ==========="
      print @player_board.render(true)
      cpu_fire
      player_fire
    end

    if (@cpu_cruiser.health == 0 && @cpu_submarine.health == 0)
      p "========== COMPUTER BOARD =========="
      print @cpu_board.render
      p "=========== PLAYER BOARD ==========="
      print @player_board.render(true)
      p "You beat the computer!"
      sleep(1)
      back_to_menu = Menu.new
      back_to_menu.main_menu
    elsif (@player_cruiser.health == 0 && @player_submarine.health == 0)
      p "========== COMPUTER BOARD =========="
      print @cpu_board.render
      p "=========== PLAYER BOARD ==========="
      print @player_board.render(true)
      p "You lost to a dumbass computer!"
      sleep(1)
      back_to_menu = Menu.new
      back_to_menu.main_menu
    end
  end

  def cpu_placement(cpu_cruiser, cpu_submarine)
    @cpu_board = Board.new

    # Random selection of horizontal or vertical placement of cruiser
    if rand(2) == 0
      horizontal_randomizer(@cpu_board, cpu_cruiser)
    else
      vertical_randomizer(@cpu_board, cpu_cruiser)
    end
    # Random selection of horizontal or vertical placement of
    if rand(2) == 0
      horizontal_randomizer(@cpu_board, cpu_submarine)
    else
      vertical_randomizer(@cpu_board, cpu_submarine)
    end
  end

  def vertical_randomizer(cpu_board, ship_type)
    coordinate_array = []
    column_start = rand(4) + 1
    row = ["A", "B", "C", "D"]
    if ship_type.name == "Cruiser"
    row_start = rand(3)
    elsif ship_type.name == "Submarine"
    row_start = rand(4)
    end

    ship_type.length.times do |count|
      coordinate_array << ([row[row_start + count]] | [(column_start).to_s]).join
    end

    # Checks for valid placement, if not recalls parent method
    if @cpu_board.valid_placement?(ship_type, coordinate_array)
      @cpu_board.place(ship_type, coordinate_array)
    else
      vertical_randomizer(cpu_board, ship_type)
    end
  end

  def horizontal_randomizer(cpu_board, ship_type)
    coordinate_array = []
    row_start = ["A", "B", "C", "D"].sample

    if ship_type.name == "Cruiser"
    column_start = rand(2) + 1
    elsif ship_type.name == "Submarine"
    column_start = rand(3) + 1
    end

    ship_type.length.times do |count|
      coordinate_array << ([row_start] | [(column_start + count).to_s]).join
    end

    # Checks for valid placement, if not recalls parent method
    if @cpu_board.valid_placement?(ship_type, coordinate_array)
      @cpu_board.place(ship_type, coordinate_array)
    else
      horizontal_randomizer(cpu_board, ship_type)
    end
  end

  def player_placement(player_cruiser, player_submarine)
    @player_board = Board.new
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)

    # Begin user input
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_placement = gets.chomp.upcase.split(' ')
    # Checks that player inputs valid coordinates
    until @player_board.valid_placement?(player_cruiser, cruiser_placement) == true
        p "The coordinates you entered are not a valid placement for the Cruiser. Try again: "
        cruiser_placement = gets.chomp.upcase.split(' ')
    end
    # Places player cruiser on Board
    @player_board.place(player_cruiser, cruiser_placement)
    @player_board.render(true)

    # Begin user input
    puts "Enter the squares for the Submarine (2 spaces):"
    submarine_placement = gets.chomp.upcase.split(' ')
    # Checks that player inputs valid coordinates
    until @player_board.valid_placement?(player_submarine, submarine_placement) == true
        p "The coordinates you entered are not a valid placement for the Submarine. Try again: "
        submarine_placement = gets.chomp.upcase.split(' ')
    end
    # Places player submarine on Board
    @player_board.place(player_submarine, submarine_placement)
    @player_board.render(true)
  end

  def cpu_fire
    possible_locations = @player_board.cells.keys
    firing_location = possible_locations.sample
    if @cpu_intelligence_next_shot != ""
      if @player_board.cells[@cpu_intelligence_next_shot].fired_upon? == false
        @player_board.cells[@cpu_intelligence_next_shot].fire_upon
      elsif @player_board.cells[@cpu_intelligence_next_shot].fired_upon? == true
        cpu_fire
      end
    else
      if @player_board.cells[firing_location].fired_upon? == false
        @player_board.cells[firing_location].fire_upon
      elsif @player_board.cells[firing_location].fired_upon? == true
        cpu_fire
      end
    end
    @cpu_intelligence_next_shot = ""
    if !@player_board.cells[firing_location].ship.nil?
      cpu_intelligence(firing_location)
    end
  end

  def cpu_intelligence(firing_location)
    split_successful_shot = firing_location.split('')
    if split_successful_shot[1].to_i < @cpu_board.cells.keys.last.split('')[1].to_i
      split_successful_shot[1] = (split_successful_shot[1].to_i + 1).to_s
      next_shot = split_successful_shot.join
      @cpu_intelligence_next_shot = next_shot
      until @player_board.cells[next_shot].fired_upon? == false
        if split_successful_shot[1].to_i < @cpu_board.cells.keys.last.split('')[1].to_i
          split_successful_shot[1] = (split_successful_shot[1].to_i + 1).to_s
          next_shot = split_successful_shot.join
          @cpu_intelligence_next_shot = next_shot
        else
          break
        end
      end
    elsif split_successful_shot[1].to_i == @cpu_board.cells.keys.last.split('')[1].to_i
      split_successful_shot[1] = (split_successful_shot[1].to_i - 1).to_s
      next_shot = split_successful_shot.join
      until @player_board.cells[next_shot].fired_upon? == false
        if split_successful_shot[1].to_i == @cpu_board.cells.keys.last.split('')[1].to_i
          (split_successful_shot[1] -= 1).to_s
          next_shot = split_successful_shot.join
          @cpu_intelligence_next_shot = next_shot
        else
          break
        end
      end
    end
    @cpu_intelligence_next_shot
    return @cpu_intelligence_next_shot
  end

  def player_fire
    print "Please enter a coordinate on which to fire your shot: "
    player_shot = gets.chomp.upcase
    until @cpu_board.valid_coordinate?(player_shot) == true
      print "That's not a valid coordinate! Try again: "
      player_shot = gets.chomp.upcase
    end
    until @cpu_board.cells[player_shot].fired_upon? == false
      print "You've already fired on that location! Try again: "
      player_shot = gets.chomp.upcase
    end
    @cpu_board.cells[player_shot].fire_upon
  end
end
