class Scope < ActiveRecord::Base
  has_many :access_token_scopes
  has_many :access_token, through: :access_token_scopes
  has_many :authorization_scopes
  has_many :authorization, through: :authorization_scopes

  validates :name, presence: true, uniqueness: true

  include ConstantCache
  caches_constants
end
