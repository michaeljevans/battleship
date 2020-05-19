require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/turn'
require './lib/menu'
require 'pry'

run_menu = Menu.new
run_menu.main_menu
