=begin
feature "spaces" do
  before do
    visit "/sessions/new"
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
    expect(page).to have_content "submitted"
  end

  it "add space" do
    visit "/spaces/new"
    fill_in "name", with: "website_test_property"
    click_on "Submit"
    expect(page).to have_content "website_test_property"
    click_on "website_test_property"
    expect(page).to have_button "request"
  end

end

=end
