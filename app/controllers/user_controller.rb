# frozen_string_literal: true

class UserController < ApplicationController
  include ApplicationHelper
  before_action :setup_steam_id, only: %i[games backlog_roulette]

  def instructions; end

  def games
    instantiate_collection_data
  end

  def backlog_roulette
    instantiate_collection_data
  end

  private

  def instantiate_collection_data
    options = { include_played_free_games: 1, include_appinfo: 1 }
    response = Steam::Player.owned_games(@id, params: options)
    @collection_data = CollectionData.new(response['games'])
  end

  def setup_steam_id
    @id = params[:user_id].strip
    if @id =~ /^[\d]{17}$/
      @vanity_name = determine_vanity_name
    else
      @vanity_name = @id.clone
      @id = steamid_64(@vanity_name)
    end
  end

  def determine_vanity_name
    return steam_display_name if logged_in? && steam_id == @id
    Steam::User.summary(@id)['personaname'] || @id
  end

  def steamid_64(vanity_name)
    Steam::User.vanity_to_steamid(vanity_name)
  end
end
