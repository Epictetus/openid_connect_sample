class IdToken < ActiveRecord::Base
  belongs_to :account
  belongs_to :client

  before_validation :setup, on: :create

  validates :user_id, presence: true
  validates :account, presence: true
  validates :client,  presence: true

  private

  def setup
    self.identifier = SecureRandom.hex(32)
    self.expires_at = 1.weeks.from_now
  end
end
