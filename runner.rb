require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/menu'
require 'pry'

def start
  run_menu = Menu.new
  run_menu.main_menu
end

def cpu_placement
  @cpu_board = Board.new
  cpu_cruiser = Ship.new("Cruiser", 3)

  if rand(2) == 0
    horizontal_randomizer(@cpu_board, cpu_cruiser)
  else
    vertical_randomizer(@cpu_board, cpu_cruiser)
  end

  cpu_submarine = Ship.new("Submarine", 2)

  if rand(2) == 0
    horizontal_randomizer(@cpu_board, cpu_submarine)
  else
    vertical_randomizer(@cpu_board, cpu_submarine)
  end

  binding.pry
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
  cpu_board.place(ship_type, coordinate_array)
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
  cpu_board.place(ship_type, coordinate_array)
end



def player_placement
  player_board = Board.new
  player_cruiser = Ship.new("Cruiser", 3)
  player_submarine = Ship.new("Submarine", 2)

  p "Enter the squares for the Cruiser (3 spaces):"
  cruiser_placement = gets.chomp
  p "Enter the squares for the Submarine (2 spaces):"
  submarine_placement = gets.chomp

  player_board.place(player_cruiser, cruiser_placement.split(" "))
  player_board.place(player_submarine, submarine_placement.split(" "))
end

start
cpu_placement
# player_placement
