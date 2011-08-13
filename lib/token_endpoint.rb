class TokenEndpoint
  attr_accessor :app
  delegate :call, to: :app

  def new
    @app = Rack::OAuth2::Server::Token.new do |req, res|
      client = Client.find_by_identifier(req.client_id) || req.invalid_client!
      client.secret == req.client_secret || req.invalid_client!
      case req.grant_type
      when :authorization_code
        code = AuthorizationCode.valid.find_by_token(req.code)
        req.invalid_grant! if code.blank? || code.redirect_uri != req.redirect_uri
        res.access_token = code.access_token.to_bearer_token(:with_refresh_token)
      else
        req.unsupported_grant_type!
      end
    end
  end
end