require 'rails_helper'

feature 'todos' do
  feature 'not logged in' do
    scenario "visit todos page should failed" do
      visit todos_path

      expect(page).to have_current_path(new_session_path)
    end
  end

  feature 'logged in' do
    background do
      create_user
      @user = User.first
      login_user @user
    end

    scenario "should open todos page successfully" do
      visit todos_path

      expect(page).to have_css 'h1', text: 'Todos list'
      expect(page).to have_css 'a', text: 'Create a Todo'
    end

    scenario "should open new page successfully" do
      visit new_todo_path

      expect(page).to have_content "Create a Todo"
    end

    scenario "should create todo successfully" do
      visit new_todo_path

      within('#todo-form') do
        fill_in 'todo[title]', with: 'My first todo'
        click_button 'Save'
      end

      expect(page).to have_current_path(todos_path)
      expect(page).to have_css 'ul li', text: 'My first todo'
    end
  end
end

feature 'complete todo' do
  background do
    create_user
    @user = User.first
    login_user @user

    @todo_1 = @user.todos.create(title: 'my first todo')
  end

  scenario 'todo should be in incomplete' do
    visit todos_path

    expect(page).to have_css "li#todo-#{@todo_1.id} span.incomplete"
    expect(find("li#todo-#{@todo_1.id}")).to have_link "设为已完成"
  end

  scenario "todo should be in complete" do
    visit todos_path

    within("li#todo-#{@todo_1.id}") do
      click_link "设为已完成"
    end

    expect(page).to have_css "li#todo-#{@todo_1.id} span.complete"
    expect(find("li#todo-#{@todo_1.id}")).to have_link "设为未完成"
  end
end
