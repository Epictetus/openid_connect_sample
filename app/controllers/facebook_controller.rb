class FacebookController < ApplicationController
  before_filter :require_anonymous_access

  def show
    authenticate Facebook.authenticate(cookies)
    redirect_to dashboard_url
  end
end
