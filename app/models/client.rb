class Client < ActiveRecord::Base
  belongs_to :account
  has_many :access_token
  has_many :authorization_code

  before_create :asetup

  def setup
    self.identifier = SecureRandom.hex(16)
    self.secret     = SecureRandom.hex(32)
  end
end
