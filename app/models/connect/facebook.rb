class Connect::Facebook < ActiveRecord::Base
  belongs_to :account

  validates :identifier,   presence: true, uniqueness: true
  validates :access_token, presence: true, uniqueness: true

  extend ActiveSupport::Memoizable

  def me
    FbGraph::User.me(self.access_token).fetch
  end
  memoize :me

  def user_info
    OpenIDConnect::ResponseObject::UserInfo::OpenID.new(
      id:       account.id,
      name:     me.name,
      email:    me.email,
      verified: me.verified
    )
  end

  class << self
    extend ActiveSupport::Memoizable

    def config
      config = YAML.load_file("#{Rails.root}/config/connect/facebook.yml")[Rails.env].symbolize_keys
      if Rails.env.production?
        config.merge!(
          client_id:     ENV['fb_client_id'],
          client_secret: ENV['fb_client_secret']
        )
      end
      config
    end
    memoize :config

    def auth
      FbGraph::Auth.new config[:client_id], config[:client_secret]
    end

    def authenticate(cookies)
      _auth_ = auth.from_cookie(cookies)
      connect = find_or_initialize_by_identifier _auth_.user.identifier
      connect.access_token = _auth_.access_token.access_token
      connect.save!
      connect.account || Account.create!(facebook: connect)
    end
  end
end
