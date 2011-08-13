class Scope < ActiveRecord::Base
  has_many :access_token_scopes
  has_many :access_token, through: :access_token_scopes
  has_many :authorization_code_scopes
  has_many :authorization_code, through: :authorization_code_scopes

  validates :name, presence: true, uniqueness: true
end
