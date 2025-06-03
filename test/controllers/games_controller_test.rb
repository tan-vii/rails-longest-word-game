require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_game_url
    assert_response :success
  end

  test 'should post score' do
    post score_game_url, params: { word: 'test', letters: 'T E S T' }
    assert_response :success
  end
end
