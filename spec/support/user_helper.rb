module UserHelper

  def create_user opts = {}
    visit new_user_path
    within('form#user_form') do
      fill_in "user[email]", with: 'test@email.com'
      fill_in "user[password]", with: "test_password"
      fill_in "user[password_confirmation]", with: "test_password"
      click_button "创建账户"
    end
  end

  def login_user user
    page.set_rack_session(user_id: user.id)
  end

end
