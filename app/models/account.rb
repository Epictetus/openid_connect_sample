class Account < ActiveRecord::Base
  has_one :facebook, :class_name => 'Connect::Facebook'
  has_one :google,   :class_name => 'Connect::Google'
  has_many :clients
  has_many :access_tokens
  has_many :authorizations
  has_many :id_tokens

  def to_response_object(scopes = [])
    user_info = if google
      google.user_info
    else
      profile = facebook.me
      OpenIDConnect::ResponseObject::UserInfo::OpenID.new(
        id:       id,
        name:     profile.name,
        email:    profile.email
        verified: profile.verified
      )
    end
    user_info.email = nil unless scopes.include?(Scope::EMAIL)
    user_info
  end
end