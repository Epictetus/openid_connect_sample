class Account < ActiveRecord::Base
  has_one :facebook
  has_many :clients
  has_many :access_tokens
  has_many :authorizations
  has_many :id_tokens

  def to_response_object(scopes)
    fb_profile = account.facebook.me
    user_info = OpenIDConnect::ResponseObject::UserInfo::OpenID.new(
      id: account.id,
      name: fb_profile.name,
      verified: fb_profile.verified
    )
    user_info.email = fb_profile.email if scopes.include?(Scope::EMAIL)
    user_info
  end
end