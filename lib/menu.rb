require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/turn'

class Menu
  attr_reader :selection

  def initialize(selection = "")
    @selection = selection
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    @selection = gets.chomp.downcase
    if @selection == "q"
      exit
    elsif @selection == "p"
      cpu_placement
    else
      puts "Invalid selection \n \n"
      main_menu
    end
  end

  def cpu_placement


    # @cells.select.valid_placement?
  end

end
