require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let!(:user) { User.create(name: 'John', email: 'john@example.com') }
  let!(:event) do
    Event.new(
      name: 'Event One', description: 'join in',
      date: '2021-06-23', location: 'Remote', creator: user
    )
  end
  subject { described_class.new(event: event, attendee: user) }

  context 'validations' do
    it 'saves a new invitation to database' do
      expect(subject.save).to be(true)
      expect(described_class.count).to eq(1)
      expect(subject.id).to be(1)
    end

    it 'validates with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'does not validate without an event' do
      subject.event = nil
      expect(subject.valid?).to be(false)
    end

    it 'does not validate without an attendee' do
      subject.attendee = nil
      expect(subject.valid?).to be(false)
    end
  end

  context 'associations' do
    it { should belong_to(:event) }
    it { should belong_to(:attendee).with_foreign_key(:user_id).class_name(:User) }
  end
end
