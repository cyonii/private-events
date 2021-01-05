require 'rails_helper'
require 'faker'

RSpec.describe Event, type: :model do
  let!(:user) { User.create(name: 'John', email: 'john@example.com') }
  let!(:params) do
    { name: 'Another Event', date: '2021-06-23', location: 'Remote Location',
      description: 'You are welcome', creator: user }
  end
  subject { described_class.new(params) }

  context 'validations' do
    it 'saves a new event to database' do
      expect(subject.save).to be(true)
      expect(described_class.count).to eq(1)
      expect(subject.id).to be(1)
    end

    it 'validates event with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'does not validate event missing data' do
      subject.name = nil
      subject.description = nil
      subject.date = nil
      subject.location = nil
      subject.creator = nil
      expect(subject.valid?).to be(false)
    end
  end

  context 'scope' do
    before :each do
      described_class.new(params.update({ date: '2025-02-02' })).save
      described_class.new(params.update({ date: '2023-11-22' })).save
      described_class.new(params.update({ date: '2019-12-19' })).save
      described_class.new(params.update({ date: '2018-01-09' })).save
      described_class.new(params.update({ date: '2002-03-14' })).save
    end

    it 'returns only events with date in the future' do
      expect(described_class.upcoming.all? { |event| event.date >= Date.today }).to be(true)
      expect(described_class.upcoming.count).to eq(2)
    end

    it 'returns only events with date in the past' do
      expect(described_class.past.all? { |event| event.date < Date.today }).to be(true)
      expect(described_class.past.count).to eq(3)
    end
  end

  context 'associations' do
    it { should belong_to(:creator).class_name(:User) }
    it { should have_many(:attendees).through(:invitations).with_foreign_key(:user_id).class_name(:User) }
    it { should have_many(:invitations).dependent(:destroy) }
  end
end
