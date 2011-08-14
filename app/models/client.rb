class Client < ActiveRecord::Base
  belongs_to :account
  has_many :access_token
  has_many :authorization

  before_validation :setup, on: :create

  validates :account,      presence: true
  validates :identifier,   presence: true, uniqueness: true
  validates :secret,       presence: true
  validates :redirect_uri, presence: true, url: true
  validates :name,         presence: true

  private

  def setup
    self.identifier = SecureRandom.hex(16)
    self.secret     = SecureRandom.hex(32)
  end
end
