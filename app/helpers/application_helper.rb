# frozen_string_literal: true

module ApplicationHelper
  def steam_profile_url
    session[:profile_url]
  end

  def steam_id
    session[:steam_id]
  end

  def steam_persona_name
    session[:persona_name]
  end

  def steam_display_name
    # include vanity name from profile url here?
    steam_persona_name || steam_id
  end

  def logged_in?
    session.key?(:steam_id)
  end

  def total_playtime_percent_string(game, collection)
    "%.2f" % (game.playtime.in_hours / collection.total_hours_played * 100.0).round(2)
  end
end
