class Account < ActiveRecord::Base
  has_one :facebook, :class_name => 'Connect::Facebook'
  has_one :google,   :class_name => 'Connect::Google'
  has_many :clients
  has_many :access_tokens
  has_many :authorizations
  has_many :id_tokens

  def profile
    if facebook
      facebook.me
    else
      google.user_info
    end
  end

  def to_response_object(scopes = [])
    user_info = OpenIDConnect::ResponseObject::UserInfo::OpenID.new(
      id: id,
      name: profile.name,
      verified: profile.verified
    )
    user_info.email = profile.email if scopes.include?(Scope::EMAIL)
    user_info
  end
end