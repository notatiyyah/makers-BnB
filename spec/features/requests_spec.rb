feature "requests" do
  before do
    visit "/sessions/new"
  end
  
  scenario "see bookings you have made" do
    visit "/requests"
    expect(page).to have_content "Requests I've made"
    click_on "testing_property"
    expect(page).not_to have_button "request"
  end

end