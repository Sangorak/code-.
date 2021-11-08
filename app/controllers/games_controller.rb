require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = [].join
    10.times do
      letter = ('A'..'Z').to_a.sample
      @letters << letter
    end
  end

  def score
    # Récupérer l'input utilisateur et le stocker
    @word = params[:answer]
    @grid = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = URI.open(url).read
    json = JSON.parse(user_serialized)
    if json['found'] == true
      @result = "Great #{@word} is valid"
    else
      @result = "Nope #{@word} is not a valid english word"
    end
  end

  private

  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end
end
