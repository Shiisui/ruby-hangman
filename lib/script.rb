puts "Manager initialized"

lines = File.readlines("google-10000-english-no-swears.txt")

secret_words_dictionary = []

lines.each do |word|
    if word.length - 1 >= 5 && word.length - 1 <= 12
        secret_words_dictionary << word
    end
end

secret_word = secret_words_dictionary.sample(1)

puts secret_word

