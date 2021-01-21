feature "session" do
  
  scenario "cannot access website without signing in" do
    visit "/spaces"
    expect(page).to have_content "You must log in or sign up to access this page"
    click_on "Sign In"
    expect(page).to have_content "You have signed in"
    visit "/spaces"
    expect(page).to have_content "unbooked_property"
  end

end