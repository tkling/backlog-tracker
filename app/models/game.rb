# frozen_string_literal: true

require 'virtus/model'

class Game
  include Virtus.model

  attribute :name, String
  attribute :appid, Integer
  attribute :playtime_forever, Integer, default: 0
  attribute :playtime_forever_hours, Float, default: lambda { |game, _| (Float(game.playtime_forever) / 60).round(2) }
end