require './spec_helper'

feature 'Adding a new user' do
  scenario 'a user can add their account to allow later login' do
    visit ('/users/new')
    fill_in('email', with: 'bob123@gmail.com')
    fill_in('password', with: 'password123')
    click_button("Sign Up")

    expect(page).to have_content 'You have signed up!'
  end
end
