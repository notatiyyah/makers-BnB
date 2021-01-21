feature "view sign up page" do
  before do
    visit "/"
  end
  
  scenario "view title" do
    expect(page).to have_content "Sign Up"
  end

end