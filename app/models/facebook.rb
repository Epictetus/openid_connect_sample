class Facebook < ActiveRecord::Base
  belongs_to :account

  validates :identifier,   presence: true, uniqueness: true
  validates :access_token, presence: true, uniqueness: true

  extend ActiveSupport::Memoizable

  def me
    FbGraph::User.me(self.access_token).fetch
  end
  memoize :me

  class << self
    extend ActiveSupport::Memoizable

    def config
      @config ||= if Rails.env.production?
        {
          client_id:     ENV['fb_client_id'],
          client_secret: ENV['fb_client_secret'],
          scope:         ENV['fb_scope']
        }
      else
        YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env].symbolize_keys
      end
    end
    memoize :config

    def auth
      FbGraph::Auth.new config[:client_id], config[:client_secret]
    end

    def authenticate(cookies)
      _auth_ = auth.from_cookie(cookies)
      fb_user = find_or_initialize_by_identifier _auth_.user.identifier
      fb_user.access_token = _auth_.access_token.access_token
      fb_user.save!
      fb_user.account || Account.create!(facebook: fb_user)
    end
  end
end
