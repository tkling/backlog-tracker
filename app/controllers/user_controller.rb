# frozen_string_literal: true

class UserController < ApplicationController
  def instructions; end

  def games
    instantiate_collection_data
  end

  def backlog_roulette
    instantiate_collection_data
  end

  private

  def instantiate_collection_data
    @id = params[:user_id]
    setup_steam_id
    setup_view_data
  end

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
    @collection_data = CollectionData.new(response['games'])
  end
end
