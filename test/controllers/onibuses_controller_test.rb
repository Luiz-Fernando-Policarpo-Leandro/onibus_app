require "test_helper"

class OnibusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @onibus = onibuses(:one)
  end

  test "should get index" do
    get onibuses_url
    assert_response :success
  end

  test "should get new" do
    get new_onibus_url
    assert_response :success
  end

  test "should create onibus" do
    assert_difference("Onibus.count") do
      post onibuses_url, params: { onibus: {} }
    end

    assert_redirected_to onibus_url(Onibus.last)
  end

  test "should show onibus" do
    get onibus_url(@onibus)
    assert_response :success
  end

  test "should get edit" do
    get edit_onibus_url(@onibus)
    assert_response :success
  end

  test "should update onibus" do
    patch onibus_url(@onibus), params: { onibus: {} }
    assert_redirected_to onibus_url(@onibus)
  end

  test "should destroy onibus" do
    assert_difference("Onibus.count", -1) do
      delete onibus_url(@onibus)
    end

    assert_redirected_to onibuses_url
  end
end
