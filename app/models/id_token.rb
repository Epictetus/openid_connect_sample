class IdToken < ActiveRecord::Base
  belongs_to :account
  belongs_to :client

  before_validation :setup, on: :create

  validates :account, presence: true
  validates :client,  presence: true

  def to_reponse_object
    OpenIDConnect::ResponseObject::IdToken.new(
      :iss     => 'https://openid-connect.herokuapp.com',
      :user_id => account.id,
      :aud     => client.identifier,
      :exp     => expires_at.to_i
    )
  end

  private

  def setup
    self.expires_at = 1.weeks.from_now
  end
end