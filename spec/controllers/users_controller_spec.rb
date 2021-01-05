require 'rails_helper'

RSpec.describe UsersController, type: :system do
  let!(:user_params) { { name: 'John Doe', email: 'johndoe@email.com' } }
  let!(:user) { User.new(user_params) }
  describe 'users management' do
    it 'creates a new user' do
      visit new_user_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[name]', with: user.name
      click_button('commit')

      expect(page).to have_content('User was successfully created')
      expect(page).to have_content('Hello, John Doe')
    end

    it 'show has expected contents' do
      user.save
      visit new_session_path
      fill_in :email, with: user.email
      click_button('commit')
      visit user_path(user)

      expect(page).to have_content("#{user.name}'s Events")
      expect(page).to have_content('Invitations')
      expect(page).to have_content('Upcoming')
      expect(page).to have_content('Past')
    end
  end
end
