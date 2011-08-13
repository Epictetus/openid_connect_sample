class Account < ActiveRecord::Base
  has_one :facebook
  has_many :clients
  has_many :access_tokens
  has_many :authorizations
end
