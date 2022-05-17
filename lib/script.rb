puts "Game initialized\n\n\n"

lines = File.readlines("google-10000-english-no-swears.txt")

secret_words_dictionary = Array.new

lines.each do |word|
    if word.length - 1 >= 5 && word.length - 1 <= 12
        secret_words_dictionary << word
    end
end

module Hangman
   class Game
        @@lives = 3
        def initialize(human, secret_word)
            @player = [human.new(self)]
            @secret_word = secret_word
        end
        

        # def play
        #     loop do 

        #         human_guess

        #         if human_has_won?
        #             print_win
        #             return
        #         elsif human_has_lost?
        #             print_lose
        #             return
        #         elsif human_false_guess
        #             print_guesses_left
        #             return
        #         end
        #     end
        # end
        def play 
            puts @player[0].guess_letter
        end
        def array_underscores
            puts "Secret word \n" + ['_','_','_','_','_','_','_'].join(" ")
        end
   end

   class Player
       def initialize(game)
            @game = game
       end
   end

   class Human < Player
        
        def guess_letter
            @game.array_underscores
            print "\n\nEnter a letter: "
            guess = gets.chomp.downcase
            return guess
        end
    
   end


end

include Hangman
secret_word = secret_words_dictionary.sample(1)
Game.new(Human, secret_word).play
