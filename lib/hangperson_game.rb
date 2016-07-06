class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_reader :word, :guesses, :wrong_guesses #, :word_with_guesses
  
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
    raise ArgumentError if letter.nil? || letter.empty? || letter !~ /[a-zA-Z]/

    return false if (@guesses + @wrong_guesses).chars.any? { |g| g.upcase == letter.upcase}

    if @word.include? letter
      @guesses += letter 
    else
      @wrong_guesses += letter
    end
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

  def update_word_with_guesses(letter)
    # match_indexes = (0 ... @word.length).find_all { |i| @word[i] == letter }
    # match_indexes.each { |i| @eword_with_guesses[i] = letter}
  end
end
