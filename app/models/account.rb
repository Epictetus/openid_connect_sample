class Account < ActiveRecord::Base
  has_one :facebook
  has_many :clients
  has_many :access_tokens
  has_many :authorizations
  has_many :id_tokens
end
