require 'openid/store/memory'

class AuthController < ApplicationController
  def via_steam_openid
    steam_oid_service = OpenID::OpenIDServiceEndpoint.from_op_endpoint_url('http://steamcommunity.com/openid/login')
    consumer = OpenID::Consumer.new(session, OpenID::Store::Memory.new)
    auth_request = consumer.begin_without_discovery(steam_oid_service, true)
    redirect_to auth_request.redirect_url('http://www.backlogtracker.com', 'http://www.backlogtracker.com/logon/success')
  end

  def result
    render text: "Claimed ID: #{params[:claimed_id]}"
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