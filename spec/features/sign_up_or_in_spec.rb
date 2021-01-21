feature 'Adding a new user' do
  before do
    visit "/users/logged_in"
  end

  scenario 'a user can add their account to allow later login' do
    visit ('/users/new')
    fill_in('email', with: 'bob123@gmail.com')
    fill_in('password', with: 'password123')
    click_button("Sign Up")
    expect(page).to have_content 'You have signed up!'
    visit ('/users/login')
    fill_in('email', with: 'bob123@gmail.com')
    fill_in('password', with: 'password123')
    click_button("Sign In")
    expect(page).to have_content 'You have logged in!'
  end
  
end
