# frozen_string_literal: true

class Game
  attr_reader :name, :appid, :playtime_forever, :playtime_forever_hours

  def initialize(steam_game_hash)
    @name             = steam_game_hash['name']
    @appid            = steam_game_hash['appid']
    @playtime_forever = steam_game_hash['playtime_forever'] || 0
    @playtime_forever_hours = (Float(@playtime_forever) / 60).round(2)
  end
end
