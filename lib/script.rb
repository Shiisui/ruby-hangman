puts "Game initialized\n\n\n"

lines = File.readlines("google-10000-english-no-swears.txt")

secret_words_dictionary = Array.new

lines.each do |word|
    if word.length - 1 >= 5 && word.length - 1 <= 12
        secret_words_dictionary << word
    end
end

module Hangman
    $incorrect_guess = []
    class Game
        @@lives = 8
        def initialize(human, secret_word)
            @player = [human.new(self)]
            @secret_word = secret_word
        end
        
        def play
            game_board = get_game_board
            loop do 
                if human_has_won?(@secret_word[0], game_board)
                    puts "You won"
                    return
                elsif human_has_lost?(@@lives)
                    puts "Game Over"
                    return
                elsif guess_false_or_true(@secret_word[0], human_guess, game_board)
                    print "lives left: " + @@lives.to_s
                    puts "    Incorrect guesses: " + $incorrect_guess.join(", ")
                end
            end
        end
        
        def human_has_lost?(lives)
            if lives < 1
                return true
            end
        end

        def human_has_won?(secret_word, game_board)
            if secret_word[0..-2] == game_board.join
                return true
            end
        end

       def guess_false_or_true(secret_word, guess, game_board)
            
            if secret_word.include?(guess)
                update_board(secret_word, guess, game_board)
            elsif @@lives != 0 
                if !($incorrect_guess.include?(guess))    
                    $incorrect_guess << guess
                    @@lives -= 1
                else 
                    print "Error, #{$incorrect_guess.join} is already incorrect. Enter a new letter"
                end
            else 
                $incorrect_guess << guess
            end
       end

        def human_guess 
            return @player[0].guess_letter
        end
        
        def update_board(secret_word, guess, game_board)
            updated_board = []
            
            secret_word = secret_word.split("")[0..-2]
            secret_word.each_with_index do |elem, idx|
               
                if elem == guess
                    game_board[idx] = elem
                end
            end
            updated_board = game_board
            print updated_board.join(" ") + "  "
            return true
            
        end

        def get_game_board
            puts @secret_word[0]
            array_underscores = []
            chars_word = @secret_word[0].split("")[0..-2]
            
            array_underscores = chars_word.map do |elem|
                elem = "_"
            end
            puts array_underscores.join(" ")
            return array_underscores
        end

        def check_input(input)
            if input.match?(/[a-z]/)
                return true 
            end
            puts "Error, we only accept Letters"
            return false
        end

        
   end

   class Player
       def initialize(game)
            @game = game
       end
   end

   class Human < Player
        
        def guess_letter
            loop do    
                print "\n\nEnter a letter: "
                guess = gets.chomp.downcase[0] 

                next if guess == nil
            
                return guess if @game.check_input(guess)

            end
        end
    
   end


end

include Hangman
secret_word = secret_words_dictionary.sample(1)
Game.new(Human, secret_word).play
