require "application_system_test_case"

class OnibusesTest < ApplicationSystemTestCase
  setup do
    @onibus = onibuses(:one)
  end

  test "visiting the index" do
    visit onibuses_url
    assert_selector "h1", text: "Onibuses"
  end

  test "should create onibus" do
    visit onibuses_url
    click_on "New onibus"

    click_on "Create Onibus"

    assert_text "Onibus was successfully created"
    click_on "Back"
  end

  test "should update Onibus" do
    visit onibus_url(@onibus)
    click_on "Edit this onibus", match: :first

    click_on "Update Onibus"

    assert_text "Onibus was successfully updated"
    click_on "Back"
  end

  test "should destroy Onibus" do
    visit onibus_url(@onibus)
    click_on "Destroy this onibus", match: :first

    assert_text "Onibus was successfully destroyed"
  end
end
