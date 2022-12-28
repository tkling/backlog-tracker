# frozen_string_literal: true

class CollectionData
  attr_reader :unparsed, :games, :total_hours_played, :most_played_game, :unplayed_games

  def initialize(steam_games_array)
    @unparsed = steam_games_array
    @games = steam_games_array.map { |game_hash| Game.new(game_hash) }
    @total_hours_played = (games.map(&:playtime_forever_hours) + [0]).sum.round(2)
    @most_played_game   = games.min { |g1, g2| g2.playtime_forever <=> g1.playtime_forever }
    @unplayed_games     = games.select { |g| g.playtime_forever.zero? }
    @played_games       = games.select { |g| g.playtime_forever.positive? }
  end

  def empty?
    games.empty?
  end

  def self.for_steam_id(steam_id)
    options = { include_played_free_games: 1, include_appinfo: 1 }
    response = Steam::Player.owned_games(steam_id, params: options)
    games = response['games'] || []
    new(games)
  end
end
