class IdTokensController < ApplicationController
  required_scopes = Scope::OPENID
  before_filter :require_access_token

  def show
    # TODO:
    # raise "invalid_id_token" or "invalid_access_token" if invalid or not found
    id_token = current_user.id_tokens.valid.where(
      client: current_token.client
    ).last
    render json: id_token.to_response_object(root_url)
  end
end
