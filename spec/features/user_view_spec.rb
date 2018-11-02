require "rails_helper"

RSpec.feature "Create new user", type: :feature do
  before do
    visit signup_path
  end
  scenario "valid input" do
    fill_in "user[name]", with: "Minh Tue"
    fill_in "user[email]", with: "nvminhtue@gmail.com"
    fill_in "user[phone]", with: "0905507959"
    fill_in "user[address]", with: "16 Ly Thuong Kiet"
    fill_in "user[password]", with: "123123"
    fill_in "user[password_confirmation]", with: "123123"
    click_button "Create account"
    expect(page).to have_current_path(root_path)
  end

  scenario "invalid input" do
    fill_in "user[name]", with: "Minh Tue"
    fill_in "user[email]", with: "nvminhtue"
    fill_in "user[phone]", with: "0905507959"
    click_button "Create account"
    expect(page).to have_current_path("/users")
  end

  scenario "show user profile" do
    user = FactoryBot.create(:user)
    visit "/users/1"
    expect(page).to have_text(user.name)
    expect(page).to have_current_path("/users/1")
  end

  scenario "edit user profile" do
    user = FactoryBot.create(:user)
    visit "/users/1/edit"
    expect(page).to have_text("Update your profile")
    expect(page).to have_text("Name")
    expect(page).to have_field("Name")
    expect(page).to have_field("Email")
    expect(page).to have_text("Email")
    expect(page).to have_field("Phone")
    expect(page).to have_text("Phone")
    expect(page).to have_field("Address")
    expect(page).to have_text("Address")
    expect(page).to have_field("Password")
    expect(page).to have_text("Password")
    expect(page).to have_field("Password confirmation")
    expect(page).to have_text("Password confirmation")
    expect(page).to have_link("Change picture",href: "http://gravatar.com/emails")
    expect(page).to have_button("Save changes")
    expect(page).to have_current_path("/users/1/edit")
  end
end
