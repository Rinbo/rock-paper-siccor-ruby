require 'colorize'
require 'yaml'

class Game
  def initialize
    @number_of_sets = 0 
    @streak = 0  
    @hand = ["Rock", "Paper", "Sciccor"]
    load_high_score
    initizalize_player
    get_referee_matrix
    select_opponent
    start_game       
  end

  def start_game
    clear_screen
    puts "Your opponent will be #{@opponent.cyan}!"
    pause
    puts "Game starts in "
    countdown(2)
    while (@number_of_sets < 10) do
      puts `clear`
      puts "Round #{@number_of_sets +1}"
      puts "#{@player.green}: #{@player_score} - #{@opponent.blue}: #{@opponent_score}"
      space
      player_choice = get_player_choice
      opponent_choice = get_opponent_choice
      print_result(player_choice, opponent_choice)
      space
      pause
      print_score
      pause
      @number_of_sets += 1
    end
    pause
    final_score
    space; pause
    if streak_record?
      puts "You achieved a new streak record! #{@streak} wins in a row!".green
      save_record
    end
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
    streak_logger(result)
    @player_score += 1 if result == "win"
    @opponent_score += 1 if result == "lose"
    puts "#{@opponent} reveals #{@hand[opponent_choice].cyan}"
    pause
    puts case result
    when "lose" then "#{@opponent.blue} wins!" 
    when "tie" then  "The set ended in a tie".yellow
    when "win" then "#{@player.green} wins!"
    end
  end

  def space
    puts ""
  end

  def get_opponent_choice
    rand(0..2)
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
      else puts "Common! Make a correct choce ffs! How hard can it be?".red
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
      pause
      $stdout.flush
      sec -= 1      
    end
  end

  def select_opponent
    opponents = ["Benny the Butcher", "Gerry the Greek", "Ronny the Ruler", "Thormorthur the Viking"]
    @opponent = opponents[rand(0..2)]
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
      puts "#{@opponent} wins!".red
    else
      puts "The game ended in a tie".yellow
    end
  end

  def streak_logger(result)
    result == "win" ? @streak += 1 : @streak = 0    
  endload_high_score

  def streak_record?
    return @streak > @high_score[0][:score]
  end

  def load_high_score
    @high_score = YAML.load_file('./high_score.yml')
  end

  def save_record
    @highscore.each do |hash|
      hash[:rank] += 1
    end
    @high_score.unshift({name: @player, score: @streak, rank: 1})
    File.open("./high_score.yml", "r") { |file| file.write(@high_score.to_yaml) }
  end  

  def clear_screen
    puts `clear`
  end
  
  def pause
    sleep 0
  end
  
end