class AuthorizationCode < ActiveRecord::Base
  belongs_to :account
  belongs_to :client
  has_many :authorization_code_scopes
  has_many :scopes, through: :authorization_code_scopes

  before_create :setup

  def setup
    self.token = SecureRandom.hex(32)
  end
end
