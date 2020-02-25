require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10).map { ('a'..'z').to_a.sample }
    # 10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    check_existing(@word)

    @answer = if !check_existing(@word)
                'Not existing'
              elsif !check_in_grid(@word, @letters)
                'Not in grid'
              else
                'Good'
              end
  end

  def check_existing(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    data = JSON.parse(open(url).read)
    data['found']
  end

  def check_in_grid(word, grid = 0)
    word.downcase.split('').each do |letter|
      # binding.pry
      if grid.include?(letter)
        grid.slice!(grid.index(letter))
      else
        return false
      end
    end
    true
  end
end
