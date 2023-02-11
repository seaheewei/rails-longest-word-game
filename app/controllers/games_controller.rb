require 'open-uri'
require 'JSON'

class GamesController < ApplicationController

  def new
    @letters = []
    @alphabet = "abcdefghijklmnopqrstuvwxyz";
    10.times do
      random = rand(26)
      @letters.push(@alphabet[random])
    end
    @letters
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer]
    # check if built out of original grid
    @in_grid = check_if_from_grid(@letters, @answer)
    # check if word is valid
    @valid = check_if_valid(@answer)
    # if @in_grid && @valid
    #   @return_value = "Congratulations! #{answer.upcase} is a valid English word!"
    # elsif @in_grid && !@valid
    #   @return_value = "Sorry but #{answer.upcase} does not seem to be a valid English word..."
    # else
    #   @return_value = "Sorry but #{answer.upcase} can't be built out of #{letters}"
    # end
  end

  def check_if_from_grid(letters, answer)
    answer.each_char do |letter|
      return false unless letters.include? letter.downcase
    end
    true
  end

  def check_if_valid(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = URI.open(url).read
    result = JSON.parse(json)
    result["found"]
  end

end
