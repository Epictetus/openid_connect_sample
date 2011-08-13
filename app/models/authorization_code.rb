class AuthorizationCode < ActiveRecord::Base
  belongs_to :account
  belongs_to :client
  has_many :authorization_code_scopes
  has_many :scopes, through: :authorization_code_scopes

  before_validation :setup, on: :create

  validates :account, presence: true
  validates :client,  presence: true

  def setup
    self.token = SecureRandom.hex(32)
  end
end
