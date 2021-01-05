require 'rails_helper'

RSpec.describe User, type: :model do
  let(:params) { { name: 'John Doe', email: 'johndoe@email.com' } }
  subject { described_class.new(params) }

  context 'validations' do
    it 'validates with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'saves a new user to database' do
      expect(subject.save).to be(true)
      expect(subject.id).to be(1)
      expect(described_class.count).to eq(1)
    end

    it 'does not validate without a name' do
      subject.name = nil
      expect(subject.valid?).to be(false)
    end

    it 'does not validate without an email' do
      subject.email = nil
      expect(subject.valid?).to be(false)
    end

    it 'ensures email is unique per user' do
      5.times { subject.save }
      expect(described_class.count).to eq(1)
    end
  end

  context 'associations' do
    it { should have_many(:events).with_foreign_key(:creator_id).class_name(:Event) }
    it { should have_many(:invitations) }
    it { should have_many(:invites).through(:invitations).source(:event) }
  end
end
