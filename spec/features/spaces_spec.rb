feature "spaces" do

  it "see available spaces" do
    visit "/spaces"
    expect(page).to have_content "testing_property"
  end

  it "add space" do
    visit "/spaces/new"
    fill_in "name", with: "website_test_property"
    click_on "Submit"
    expect(page).to have_content "website_test_property"
  end

end