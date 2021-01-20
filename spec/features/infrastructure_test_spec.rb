feature 'Testing infrastructure' do
  before do
    visit "/sessions/new"
  end

  scenario "testing infrastructure" do
    visit("/test")
    expect(page).to have_content "Testing infrastructure working!"
  end
  
end