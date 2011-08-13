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

  scope :valid, lambda {
    where { expires_at >= Time.now.utc }
  }

  def to_bearer_token
    Rack::OAuth2::AccessToken::Bearer.new(
      :access_token => token,
      :expires_in   => (expires_at - Time.now.utc).to_i
    )
  end

  def accessible?(scopes = nil)
    Array(scopes).all? do |_scope_|
      scopes.include? _scope_
    end or raise Rack::OAuth2::Server::Resource::Bearer::Forbidden
  end

  private

  def setup
    self.token      = SecureRandom.hex(32)
    self.expires_at = 24.hours.from_now
  end
end
