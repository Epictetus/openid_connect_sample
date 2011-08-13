module Authentication

  class AuthenticationRequired < StandardError; end
  class AnonymousAccessRequired < StandardError; end

  def self.included(klass)
    klass.send :include, Authentication::Helper
    klass.send :before_filter, :optional_authentication
    klass.send :cattr_accessor, :required_scopes
    klass.send :rescue_from, AuthenticationRequired,  with: :authentication_required!
    klass.send :rescue_from, AnonymousAccessRequired, with: :anonymous_access_required!
  end

  module Helper
    def current_account
      @current_account
    end

    def current_token
      @current_token
    end

    def authenticated?
      !current_account.blank?
    end
  end

  def authentication_required!(e)
    redirect_to root_url, flash: {
      error: e.message || 'Authentication Required'
    }
  end

  def anonymous_access_required!(e)
    redirect_to dashboard_url
  end

  def optional_authentication
    if session[:current_account]
      authenticate Account.find_by_id(session[:current_account])
    end
  rescue ActiveRecord::RecordNotFound
    unauthenticate!
  end

  def require_authentication
    raise AuthenticationRequired.new unless authenticated?
  end

  def require_anonymous_access
    raise AnonymousAccessRequired.new if authenticated?
  end

  def require_access_token
    @current_token = AccessToken.valid.find_by_token request.env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN]
    raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized unless @current_token
    @current_token.accessible? @required_scopes
  end

  def authenticate(account)
    if account
      @current_account = account
      session[:current_account] = account.id
    end
  end

  def unauthenticate!
    @current_account = session[:current_account] = nil
  end
end