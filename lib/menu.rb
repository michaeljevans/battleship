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
      turn = Turn.new
      turn.play
    else
      puts "Invalid selection \n \n"
      main_menu
    end
  end

end
