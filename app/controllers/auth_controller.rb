require 'openid/store/memory'

class AuthController < ApplicationController
  def via_steam_openid
    discovery_result = OpenID.discover_uri('http://steamcommunity.com/openid')
    consumer = OpenID::Consumer.new(session, OpenID::Store::Memory.new)
    service_endpoint = discovery_result[1].first
    auth_request = consumer.begin_without_discovery(service_endpoint, true)
    redirect_to auth_request.redirect_url(base_url, "#{base_url}/logon/success")
  end

  def result
    render text: "Claimed ID: #{params[:claimed_id]}\n\n\nparams:#{params}"
  end

  private
  def base_url
    "http://#{request.env['HTTP_HOST']}"
  end
  # public ActionResult ViaSteamOpenId() {
  #   if (this.HttpContext.Request.UrlReferrer != null) {
  #       var openid = new OpenIdRelyingParty();
  #   string baseServerUrl = "http://" + this.HttpContext.Request.UrlReferrer.Authority;
  #
  #   IAuthenticationRequest request = openid.CreateRequest(
  #                              Identifier.Parse("http://steamcommunity.com/openid"),
  #                              new Realm(baseServerUrl),
  #                                  new Uri(baseServerUrl + "/logon/success")
  #                          );
  #
  #   return request.RedirectingResponse.AsActionResult();
  #   } else {
  #       return RedirectToAction("index", "home");
  #   }
  #   }
end