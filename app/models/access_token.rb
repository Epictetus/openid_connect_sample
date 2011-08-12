class AccessToken < ActiveRecord::Base
  belongs_to :account
  belongs_to :client
  has_many :access_token_scopes
  has_many :scopes, through: :access_token_scopes

  before_create :setup

  def setup
    self.token = SecureRandom.hex(32)
  end
end
