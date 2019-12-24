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
end
