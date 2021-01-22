feature "spaces" do
  before do
    visit "/debug/log_in"
  end

  it "see available spaces" do
    visit "/spaces"
    expect(page).to have_content "unbooked_property"
  end

  it "book_space" do
    visit "/spaces"
    expect(page).to have_content("unbooked_property", count: 2)
    click_on("unbooked_property", match: :first)
    click_on "request"
    expect(page).to have_content "Booking Submitted"
  end

  it "add space" do
    visit "/spaces/new"
    fill_in "name", match: :first, with: "website_test_property"
    fill_in "description", with: "this is a property for testing adding spaces"
    fill_in "price", with: "20"
    fill_in "start_date", with: "2021-01-01"
    fill_in "end_date", with: "2021-12-31"
    click_on "List my space"
    expect(page).to have_content "website_test_property"
    click_on "website_test_property"
    expect(page).to have_button "request"
  end

end
