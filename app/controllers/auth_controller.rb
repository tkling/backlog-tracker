require 'openid/store/memory'

class AuthController < ApplicationController
  def via_steam_openid
    consumer = OpenID::Consumer.new(session, OpenID::Store::Memory.new)
    auth_request = consumer.begin('http://steamcommunity.com/openid')
    redirect_to auth_request.redirect_url(base_url, "#{base_url}/auth/result")
  end

  def result
    claimed_id_url = params['openid.claimed_id']

    if claimed_id_url && !(matches = claimed_id_url.scan(/[\d]{17}/)).empty?
      redirect_to user_games_url(matches.first)
    else
      redirect_to :auth_start
    end
  end

  private
  def base_url
    "http://#{request.env['HTTP_HOST']}"
  end
end