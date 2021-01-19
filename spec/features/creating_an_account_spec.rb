require './spec_helper'

feature 'Adding a new user' do
  scenario 'a user can add their account to allow later login' do
    visit ('makers_bnb/users/new')
    fill_in('username', with: 'bob123')
    fill_in('password', with: 'password123')
    click_button('Submit')

    expect(page).to have_content 'you have signed in!'
  end
end
