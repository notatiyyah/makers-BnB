feature "spaces" do

  it "see available spaces" do
    visit "/spaces"
    expect(page).to have_content "testing_property"
  end

  it "book_space" do
    visit "/spaces"
    expect(page).to have_content("testing_property", count: 2)
    click_on("testing_property", match: :first)
    click_on "request"
    expect(page).to have_content "submitted"
    visit "/spaces"
    expect(page).not_to have_content("testing_property", count: 2)
  end

  it "add space" do
    visit "/spaces/new"
    fill_in "name", with: "website_test_property"
    click_on "Submit"
    expect(page).to have_content "website_test_property"
  end

end
