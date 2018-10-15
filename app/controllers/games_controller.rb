require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].split('')
    @letters = params[:letters].tr('\", \"', '').tr('[', '').tr(']', '')
    @word.each do |letter|
      if !@letters.split('').include? letter.upcase
        @result = "The word can't be built out of the original grid"
      elsif english_word?(@word.join) == false
        @result = "This is not a valid English word"
      else "Congrats"
      end
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
