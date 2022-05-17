puts "Game initialized\n\n\n"

lines = File.readlines("google-10000-english-no-swears.txt")

secret_words_dictionary = Array.new

lines.each do |word|
    if word.length - 1 >= 5 && word.length - 1 <= 12
        secret_words_dictionary << word
    end
end

module Hangman
    $letters_entered = []
    class Game
        @@lives = 3
        def initialize(human, secret_word)
            @player = [human.new(self)]
            @secret_word = secret_word
        end
        
        def play
            game_board = get_game_board
            loop do 

                guess_false_or_true(@secret_word[0], human_guess, game_board)
                
                # if human_has_won?(@secret_word)
                #     print_win
                #     return
                # elsif human_has_lost?
                #     print_lose
                #     return
                # elsif guess_false_or_true(@secret_word, human_guess)
                #     print_guesses_left
                #     return
                # end
            end
        end
        
       def guess_false_or_true(secret_word, guess, game_board)
            
            if secret_word.include?(guess)
                update_board(secret_word, guess, game_board)
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
            p updated_board.join(" ")
            puts @@lives
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

        
   end

   class Player
       def initialize(game)
            @game = game
       end
   end

   class Human < Player
        
        def guess_letter
            
            print "\n\nEnter a letter: "
            guess = gets.chomp.downcase[0]
            return guess
        end
    
   end


end

include Hangman
secret_word = secret_words_dictionary.sample(1)
Game.new(Human, secret_word).play
