feature 'Testing infrastructure' do
  scenario "testing infrastructure" do
    visit("/debug/test")
    expect(page).to have_content "Testing infrastructure working!"
  end
end
