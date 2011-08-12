class FacebookController < ApplicationController
  def show
    authenticate Facebook.authenticate(cookies)
    redirect_to dashboard_url
  end
end
