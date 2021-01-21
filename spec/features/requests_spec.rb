=begin
feature "requests" do
  before do
    visit "/sessions/new"
  end

  scenario "see bookings you have made" do
    visit "/requests"
    expect(page).to have_content "Requests I've made"
    click_on("testing_property", match: :first)
    expect(page).not_to have_button "request"
  end

  scenario "see bookings you have recieved" do
    visit "/requests"
    expect(page).to have_content "Requests I've received"
    click_on("received_requests", match: :first)
    expect(page).to have_content "From: 1"
    expect(page).to have_content "Other requests for this Space"
  end

end

=end
