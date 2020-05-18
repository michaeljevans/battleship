require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/menu'
require './lib/turn'
require 'pry'

def start
  run_menu = Menu.new
  run_menu.main_menu
end

start
turn = Turn.new
turn.cpu_placement
turn.player_placement
binding.pry

# @cpu_board.render(true)
# @player_board.render(true)
