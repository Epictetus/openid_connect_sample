class AccessTokenScope < ActiveRecord::Base
  belongs_to :access_token
  belongs_to :scope
end
