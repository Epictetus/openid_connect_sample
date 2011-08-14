require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test 'setup' do
    client = accounts(:nov).clients.create!(
      name: 'Sample',
      redirect_uri: 'https://client.example.com/callback'
    )
    assert client.identifier
    assert client.secret
  end
end
