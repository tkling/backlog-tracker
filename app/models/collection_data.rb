# frozen_string_literal: true

class CollectionData
  attr_reader :games, :total_hours_played, :most_played_game, :unplayed_games

  def initialize(steam_games_array)
    @games = steam_games_array.map { |game_hash| Game.new(game_hash) }
    @total_hours_played = games.map(&:playtime_forever_hours).sum.round(2)
    @most_played_game   = games.min { |g1, g2| g2.playtime_forever <=> g1.playtime_forever }
    @unplayed_games     = games.select { |g| g.playtime_forever.zero? }
  end
end