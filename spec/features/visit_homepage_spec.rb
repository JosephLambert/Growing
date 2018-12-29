require 'rails_helper'

# Capybara system test API
# feature -> describe from Rspec
# scenario -> it from Rspec

feature "visit homepage" do

  scenario "should successfully" do
    visit root_path

    expect(page).to have_content 'Home'
  end
end
