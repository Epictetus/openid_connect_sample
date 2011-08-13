class AccessToken < ActiveRecord::Base
  belongs_to :account
  belongs_to :client
  has_many :access_token_scopes
  has_many :scopes, through: :access_token_scopes

  before_validation :setup, on: :create

  validates :account,    presence: true
  validates :client,     presence: true
  validates :token,      presence: true, uniqueness: true
  validates :expires_at, presence: true

  private

  DEFAULT_LIFETIME = 24.hours

  def setup
    self.token = SecureRandom.hex(32)
    self.expires_at = DEFAULT_LIFETIME.from_now
  end
end
