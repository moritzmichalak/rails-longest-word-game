# frozen_string_literal: true

class GamesController < ApplicationController
  def new
    @letters = []
    alphab = ('A'..'Z').to_a
    @letters << alphab[rand(0..25)] until @letters.length == 10
  end

  def score
    # raise
    @grid = params[:grid]
    @guess = params[:guess]
    # appeller methode cor
    @dictionary = dicto?(@guess)
    @include = comparison?(@grid, @guess)
  end

  private

  def dicto?(word)
    require 'json'
    require 'open-uri'
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    word['found']
  end

  def comparison?(gri, gue)
    gue.upcase.split('').all? do |c|
      gue.upcase.split('').count(c) <= gri.count(c)
    end
  end
end
