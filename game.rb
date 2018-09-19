require 'colorize'

class Game
  def initialize
    @number_of_sets = 0
    @hand = ["Rock", "Paper", "Sciccor"]
    initizalize_player
    get_referee_matrix
    select_opponent
    start_game       
  end

  def start_game
    puts "Your opponent will be #{@opponent}!"
    sleep 1
    puts "Game starts in "
    countdown(1)
    while (@number_of_sets < 10) do
      player_choice = get_player_choice
      opponent_choice = get_opponent_choice
      puts print_result(player_choice, opponent_choice)
      space
      sleep 1
      print_score
      sleep 1
      @number_of_sets += 1
    end
    sleep 1
    final_score
    sleep 1
  end
  private

  def initizalize_player
    puts "~"*40 
    print "What is your name? ".yellow
    @player = gets.chomp
    @player_score = 0 
  end

  def print_result(player_choice, opponent_choice)
    result = @matrix[opponent_choice][player_choice]
    @player_score += 1 if result == "win"
    @opponent_score += 1 if result == "lose"
    puts "#{@opponent} reveals #{@hand[opponent_choice].cyan}"
    sleep 1
    return case result
    when "lose" then "#{@opponent.blue} wins!" 
    when "tie" then  "The set ended in a tie".yellow
    when "win" then "#{@player.green} wins!"
    end
  end

  def space
    puts ""
  end

  def get_opponent_choice
    (rand*2).round
  end
  
  def get_player_choice
    valid_choice = false
    space
    puts "Make your choice!" 
    while !valid_choice 
      space         
      puts "1. Rock"
      puts "2. Paper"
      puts "3. Siccor"
      choice = gets.chomp.downcase
      case choice
      when "1", "rock"
        valid_choice = true
        player_choice = 0
      when "2", "paper"
        valid_choice = true
        player_choice = 1
      when "3", "siccor"
        valid_choice = true
        player_choice = 2
      else puts "Common! Make a correct choce ffs! How hard can it be?"
      end
    end
    player_choice
  end

  def get_referee_matrix
    t = "tie"; w = "win"; l="lose"
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
    @opponent_score = 0
  end

  def print_score
    puts "The score is now:"
    puts "#{@player.green}: #{@player_score}"
    puts "#{@opponent.blue}: #{@opponent_score}"
  end

  def final_score
    puts "Final score - #{@player.green}: #{@player_score} - #{@opponent.cyan}: #{@opponent_score}"
    if @player_score > @opponent_score
      puts "#{@player} wins!".green
    elsif @player_score < @opponent_score
      puts "#{@opponent} wins!"
    else
      puts "The game ended in a tie".yellow
    end
  end

end