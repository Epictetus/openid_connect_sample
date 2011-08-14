require 'test_helper'

class IdTokenTest < ActiveSupport::TestCase
  test 'setup' do
    id_token = accounts(:nov).id_tokens.create!(client: clients(:nov))
    assert_in_delta 1.weeks.from_now, id_token.expires_at, 3
  end

  test 'to_response_object' do
    response_object = id_tokens(:nov).to_response_object('https://server.example.com')
    assert response_object.is_a?(OpenIDConnect::ResponseObject::IdToken)
    assert_equal 'https://server.example.com', response_object.iss
  end
end