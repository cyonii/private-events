require 'rails_helper'

RSpec.describe InvitationsController, type: :system do
  let(:user) { User.new(name: 'John Doe', email: 'johndoe@email.com') }

  describe 'session management' do
    before :each do
      user.save
      visit new_session_path
      fill_in :email, with: user.email
      click_button('commit')
    end

    it 'signs in user' do
      expect(page).to have_content('Signed in successfully')
      expect(page).to have_content("Hello, #{user.name}")
    end

    it 'signs out user' do
      click_link('Logout')
      expect(page).to have_content('Signed out successfully')
    end
  end
end
