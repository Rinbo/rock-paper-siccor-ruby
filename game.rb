require 'colorize'

class Game
  def initialize
    @number_of_sets = 0
    initizalize_player
    get_referee_matrix
    select_opponent
    start_game    
  end

  def start_game
    puts "Your opponent will be #{@opponent}!"
    sleep 1
    puts "Game starts in "
    countdown(3)
    while (@number_of_sets < 10) do
      player_choice = present_choices
      puts player_choice
      @number_of_sets += 1   
    end
  end
  private

  def initizalize_player
    puts "~"*40 
    print "What is your name? ".yellow
    @player = gets.chomp    
  end

  def space
    puts ""
  end

  def present_choices
    valid_choice = false
    puts "Make your choice! Quickly!"
    while !valid_choice 
      space         
      puts "1. Rock"
      puts "2. Paper"
      puts "3. Siccor"
      choice = gets.chomp.downcase
      case choice
      when "1", "rock"
        valid_choice = true
        player_choice = 1
      when "2", "paper"
        valid_choice = true
        player_choice = 2
      when "3", "siccor"
        valid_choice = true
        player_choice = 3
      else puts "common! Make a correct choce ffs! How hard can it be?"
      end
    end
    player_choice
  end

  def get_referee_matrix
    t = "Tie", w = "Win"; l="lose"
    @matrix = [[t,w,l],[l,t,w],[w,l,t]]
  end

  def countdown(sec)    
    sec.times do      
      print sec.to_s+"\r"  
      sleep 1
      $stdout.flush
      sec -= 1      
    end
  end

  def select_opponent
    opponents = ["Benny the Butcher", "Gerry the Greek", "Ronny the Ruler", "Thormorthur the Viking"]
    @opponent = opponents[(rand*3).to_i]
  end

end