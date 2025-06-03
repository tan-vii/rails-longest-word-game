# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')

    @message =
      if !word_in_grid?(@word, @letters)
        "Sorry, your word can't be built out of the original grid."
      elsif !valid_english_word?(@word)
        "Sorry, '#{@word}' is not a valid English word."
      else
        "Well done! '#{@word}' is a valid English word!"
      end
  end

  private

  def word_in_grid?(word, grid)
    grid_upcase = grid.map(&:upcase)
    word.upcase.chars.all? do |letter|
      word.upcase.count(letter) <= grid_upcase.count(letter)
    end
  end

  def valid_english_word?(word)
    url = URI("https://api.dictionaryapi.dev/api/v2/entries/en/#{word.downcase}")
    response = Net::HTTP.get_response(url)
    return false unless response.is_a?(Net::HTTPSuccess)

    result = JSON.parse(response.body)
    result.is_a?(Array)
  rescue StandardError => e
    Rails.logger.error "Error validating word: #{e.message}"
    false
  end
end
