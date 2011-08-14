class Connect::GoogleController < ApplicationController
  before_filter :require_anonymous_access

  def show
    authenticate Connect::Google.authenticate(params[:code])
    redirect_to dashboard_url
  end
end
