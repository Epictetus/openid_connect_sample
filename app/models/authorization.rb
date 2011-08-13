class Authorization < ActiveRecord::Base
  belongs_to :account
  belongs_to :client
  has_many :authorization_scopes
  has_many :scopes, through: :authorization_scopes

  before_validation :setup, on: :create

  validates :account, presence: true
  validates :client,  presence: true

  scope :valid, lambda {
    where { expires_at >= Time.now.utc }
  }

  def expire!
    self.expires_at = Time.now
    self.save!
  end

  private

  def setup
    self.code       = SecureRandom.hex(32)
    self.expires_at = 5.minutes.from_now
  end
end
