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
      steam_id = matches.first
      write_session_data(steam_id)
      redirect_to user_games_url(steam_id)
    else
      wipe_session
      redirect_to :auth_start
    end
  end

  def logout
    wipe_session
    redirect_to :home
  end

  private

  def base_url
    "http://#{request.env['HTTP_HOST']}"
  end

  def write_session_data(steam_id)
    user_summary = Steam::User.summary(steam_id)
    session[:steam_id] = steam_id
    session[:persona_name] = user_summary['personaname']
    session[:profile_url] = user_summary['profileurl']
  end

  def wipe_session
    session.clear
  end
end