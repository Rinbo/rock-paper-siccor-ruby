require 'colorize'
require './game.rb'
require 'yaml'
require 'pp'

puts "Welcome to Rock Paper Sizzor!".green

def print_highscore
  high_score = YAML.load_file('./high_score.yml')
  puts "Rank   |    Name     |    Streak"
  puts "-"*35
  high_score.each do |h|
    puts "#{h[:rank]}      |    #{h[:name]}    |     #{h[:score]}"
  end    
end

while true
  puts " "
  puts "~"*40  
  puts "Choose an option:" 
  puts "1. Rules".cyan
  puts "2. Start game".blue 
  puts "3. View highest streaks"
  puts "4. Quit".yellow
    
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
  when "highscore", "3"
    print_highscore
  when "quit", "q", "4"
    break
  else
    puts " "
    puts "I didn't get that. Try again!".red
  end 

end

