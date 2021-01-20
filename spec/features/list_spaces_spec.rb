feature "list spaces" do

  it "see available spaces" do
    visit "/spaces"
    expect(page).to have_content "testing_property"
  end

end