# frozen_string_literal: true
class UserController < ApplicationController
  def instructions; end

  def games
    index
  end

  def index
    @id = params[:user_id]
    setup_steam_id
    setup_view_data
  end

  private

  def setup_steam_id
    @id.strip!
    if @id =~ /^[\d]{17}$/
      @vanity_name = session[:persona_name]
    else
      @vanity_name = @id.clone
      @id = steamid_64(@id)
    end
  end

  def steamid_64(vanity_name)
    Steam::User.vanity_to_steamid(vanity_name)
  end

  def setup_view_data
    options = { include_played_free_games: 1, include_appinfo: 1 }
    response = Steam::Player.owned_games(@id, params: options)

    @games = response['games'].map { |g| Game.new(g) }
    @most_played_game = @games.min { |g1, g2| g2.playtime_forever <=> g1.playtime_forever }
    @total_hours_played = @games.map(&:playtime_forever_hours).inject(:+).round(2)
    @unplayed = @games.select { |g| g.playtime_forever == 0 }
  end
end
