class AccessTokensController < ApplicationController
  include RespondAsRackApp

  def create
    respond_as_rack_app TokenEndpoint.new.call(request.env)
  end
end
