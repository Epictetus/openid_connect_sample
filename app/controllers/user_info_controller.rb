class UserInfoController < ApplicationController
  required_scopes = Scope::OPENID
  before_filter :require_access_token

  def show
    render json: current_account.to_response_object(current_token.scopes)
  end
end
