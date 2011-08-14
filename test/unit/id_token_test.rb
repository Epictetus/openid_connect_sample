require 'test_helper'

class IdTokenTest < ActiveSupport::TestCase
  test 'to_response_object should use given base_url as iss' do
    id_token = accounts(:nov).id_tokens.create!(client: clients(:nov))
    response_object = id_token.to_response_object('https://server.example.com')
    assert_equal 'https://server.example.com', response_object.iss
  end
end