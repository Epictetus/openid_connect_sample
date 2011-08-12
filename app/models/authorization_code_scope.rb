class AuthorizationCodeScope < ActiveRecord::Base
  belongs_to :authorization_code
  belongs_to :scope
end
