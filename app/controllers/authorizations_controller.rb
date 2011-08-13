class AuthorizationsController < ApplicationController
  before_filter :require_authentication

  rescue_from Rack::OAuth2::Server::Authorize::BadRequest do |e|
    @error = e
    render :error, :status => e.status
  end

  def new
    call_authorization_endpoint
  end

  def create
    call_authorization_endpoint :allow_approval, params[:approve]
  end

  private

  include RespondAsRackApp
  def call_authorization_endpoint(allow_approval = false, approved = false)
    endpoint       = AuthorizationEndpoint.new current_account, allow_approval, approved
    rack_response  = *endpoint.call(request.env)
    @client        = endpoint.client
    @response_type = endpoint.response_type
    respond_as_rack_app *rack_response
  end
end
