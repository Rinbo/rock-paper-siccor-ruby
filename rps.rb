require 'colorize'
require './game.rb'

puts "Welcome to Rock Paper Sizzor!".green

while true
  puts " "
  puts "~"*40  
  puts "Choose an option:" 
  puts "1. Rules".cyan
  puts "2. Start game".blue 
  puts "3. Quit".yellow
  
  input = gets.chomp.downcase
  
  case input
  when "rules", "1"
    puts " "
    puts "Rules of the game:"
    puts "Rock > Siccor | Siccor > Paper | Paper > Rocks".cyan
  when "start", "start game", "s", "2"
    puts " "
    puts "Game commencing...".green
    game = Game.new
  when "quit", "q", "3"
    break
  else
    puts " "
    puts "I didn't get that. Try again!".red
  end  
end

