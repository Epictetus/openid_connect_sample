class FacebookController < ApplicationController
  def show
    authenticate Auth::Facebook.authenticate(cookies)
    redirect_to dashboard_url
  end
end
