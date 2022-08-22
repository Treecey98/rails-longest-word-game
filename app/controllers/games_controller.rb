class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []

    counter = 0
    while counter < 10
      @letters << ('A'...'Z').to_a.sample
      counter += 1
    end
  end

  def score
    @answer = params[:word].upcase
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_validation = URI.open(url).read
    word_data = JSON.parse(word_validation)

    if word_data['found'] && @answer.chars.all? { |letter| @letters.include?(letter) }
      @message = "Congratulations #{@answer} is a valid English word!"
    elsif word_data['found'] && @answer.chars.all? { |letter| @letters.include?(letter) } == false
      @message = "Sorry but #{@answer} cannot be built out of #{@letters}"
    else
      @message = "Sorry but #{@answer} does not seem to be a valid English word"
    end
  end
end
