class AuthorizationCodeScope < ActiveRecord::Base
  belongs_to :authorization_code
  belongs_to :scope

  validates :authorization_code, presence: true
  validates :scope,              presence: true
end
