class HangpersonGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_reader :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses =  ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError, 'Invalid Guess' if letter.nil? || letter.empty? || letter !~ /[a-zA-Z]/

    return false if (@guesses + @wrong_guesses).upcase.include? letter.upcase

    (@word.include? letter) ? @guesses += letter : @wrong_guesses += letter
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length == 7 
    return :win if !@word.empty? && word_with_guesses == @word 
    :play
  end

  def word_with_guesses
    @word.chars.each_with_index.inject(@word.gsub(/./,'-')) do | result, (word_letter, index) |
      result[index] = word_letter if @guesses.include? word_letter
      result
    end
  end

end
