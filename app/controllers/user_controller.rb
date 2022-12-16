# frozen_string_literal: true

class UserController < ApplicationController
  include ApplicationHelper
  before_action :setup_steam_id, only: %i[games backlog_roulette]

  def instructions; end

  def games
    expires_in 5.minutes
    fetch_collection_data
    fetch_friend_persona_names
  end

  def backlog_roulette
    expires_in 30.seconds
    fetch_collection_data
  end

  private

  def fetch_friend_persona_names
    friend_ids = Steam::User.friends(@id).pluck('steamid')
    summaries = Steam::User.summaries(friend_ids)
    id_vanity_map = Hash[summaries.map{|s| [s['steamid'], s['personaname']]}]
    prefix = "id-vanity-map-"
    cache_key = -> (steamid) { "#{prefix}#{steamid}" }
    unkeyed = -> (cache_key) { cache_key.delete_prefix(prefix) }
    keys = summaries.pluck('steamid').map(&cache_key)
    @ids_to_vanities =
      Rails.cache.fetch_multi(*keys, expires_in: 10.minutes) {|k| id_vanity_map[unkeyed.(k)] }
                 .transform_keys {|k| unkeyed.(k) }
  end

  def fetch_collection_data
    @collection_data = CollectionData.for_steam_id(@id)
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
