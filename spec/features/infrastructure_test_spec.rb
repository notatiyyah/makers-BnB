require 'spec_helper'

feature 'Testing infrastructure' do
  scenario "testing infrastructure" do
    visit("/test")
    expect(page).to have_content "Testing infrastructure working!"
  end
end