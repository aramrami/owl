# frozen_string_literal: true

require 'test_helper'

class PrioritiesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get '/priorities/index'
    assert_response :success
  end
end
