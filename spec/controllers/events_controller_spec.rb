require 'rails_helper'

RSpec.describe EventsController, type: :system do
  let(:user) { User.create(name: 'John Doe', email: 'johndoe@email.com') }
  let(:event_params) do
    {
      name: 'RubyCON', date: '2023-06-23', location: 'Remote',
      description: 'For Rubyists', creator: user
    }
  end
  let(:event) do
    Event.new(event_params)
  end

  describe 'event management' do
    before :each do
      event.save
      visit new_session_path
      fill_in :email, with: user.email
      click_button('commit')
    end

    it 'creates a new event' do
      visit new_event_path
      fill_in :event_name, with: 'New Event'
      fill_in :event_description, with: 'Welcome to new event'
      fill_in :event_location, with: 'Earth'
      click_button('commit')

      expect(page).to have_content('Event was successfully created')
    end

    it "adds user to event's attendees using `Attend Event` button" do
      visit event_path(event)
      click_button('Attend Event')

      expect(page).to have_content('Attending')
      expect(page).to have_content('Successfully added attendee')
    end

    it "adds user to event's attendees through form" do
      visit event_path(event)
      fill_in :email, with: user.email
      click_button('Invite')

      expect(page).to have_content('Attending')
      expect(page).to have_content('Successfully added attendee')
    end

    it 'cancels an invitation' do
      visit event_path(event)
      click_button('Attend Event')
      click_link 'Cancel'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'Your invitation has been cancelled'
    end
  end
end
