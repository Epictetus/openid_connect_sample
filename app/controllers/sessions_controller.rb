class SessionsController < ApplicationController
  def destroy
    unauthenticate!
    redirect_to root_url
  end
end
