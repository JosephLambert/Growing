require 'rails_helper'

feature 'user login' do
  scenario 'should open login page successfully' do
    visit new_session_path

    expect(page).to have_content "登陆"
  end

  scenario 'should login failed' do
    visit new_session_path

    within("form#login-form") do
      fill_in "email", with: "test_email"
      fill_in "password", with: "test_password"
      click_button "登陆"
    end

    expect(page).to have_content "邮箱或者密码不正确"
  end

  scenario 'should login successfully' do
    create_user
    visit new_session_path

    within('form#login-form') do
      fill_in "email", with: 'test@email.com'
      fill_in "password", with: "test_password"
      click_button "登陆"
    end

    expect(page).to have_current_path(root_path)
  end

end
