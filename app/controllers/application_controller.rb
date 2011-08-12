class ApplicationController < ActionController::Base
  include Authentication
  include Notification

  rescue_from FbGraph::Exception do |e|
    redirect_to root_url, flash: {error: e.message}
  end

  protect_from_forgery
end
