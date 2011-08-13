require 'rack/oauth2/server/authorize/extension/code_and_token'

class AuthorizationEndpoint
  attr_accessor :app, :client, :response_type
  delegate :call, to: :app

  def initialize(current_account, allow_approval = false, approved = false)
    @app = Rack::OAuth2::Server::Authorize.new do |req, res|
      @client = Client.find_by_identifier(req.client_id) || req.bad_request!
      res.redirect_uri = req.verify_redirect_uri!(@client.redirect_uri)
      if allow_approval
        if approved
          case req.response_type
          when :code, :token, :id_token, [:code, :token], [:id_token, :token]
            response_types = Array(req.response_type)
            if response_types.include? :code
              authorization = current_account.authorizations.create(:client_id => @client, :redirect_uri => res.redirect_uri)
              res.code = authorization.code
            end
            if response_types.include? :token
              res.access_token = current_account.access_tokens.create(:client_id => @client).to_bearer_token
            end
            if response_types.include? :id_token
              # TODO
            end
          else
            res.unsupported_response_type!
          end
          res.approve!
        else
          req.access_denied!
        end
      else
        @response_type = req.response_type
      end
    end
  end
end