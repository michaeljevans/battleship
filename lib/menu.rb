require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'

class Menu
  attr_reader :selection

  def initialize(selection = "")
    @selection = selection
  end

  def main_menu
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    @selection = gets.chomp.downcase
    if @selection == "q"
      exit
    elsif @selection == "p"
      cpu_placement
    else
      p "Invalid selection"
    end
  end

  def cpu_placement


    # @cells.select.valid_placement?
  end

end
