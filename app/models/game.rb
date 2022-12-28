# frozen_string_literal: true

class Game
  attr_reader :name, :appid, :playtime_forever, :playtime_forever_hours, :playtime

  def initialize(steam_game_hash)
    @name             = steam_game_hash['name']
    @appid            = steam_game_hash['appid']
    @playtime_forever = steam_game_hash['playtime_forever'] || 0
    @playtime         = Playtime.new(@playtime_forever)
    @playtime_forever_hours = @playtime.hours
  end

  def to_s
    "#{name}"
  end
end

class Playtime
  attr_reader :in_hours, :hours, :minutes

  def initialize(minutes_played)
    @in_hours = minutes_played.minutes.in_hours
    @hours = in_hours.floor
    @minutes = (in_hours.hours - @hours.hours).in_minutes.floor
  end

  def to_s
    "#{hours}:#{minutes.to_s.rjust(2, '0')}"
  end
end
