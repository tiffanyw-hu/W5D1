# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create!(username: 'joe', password: 'password') }

  describe "validation" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe '::find_by_credentials' do
    it 'returns the user when given valid credentials' do
      subject.save
      user = User.find_by_credentials(subject.username, subject.password)
      expect(user.username).to eq(subject.username)
    end
  end

  describe '#ensure_session_token' do
    it 'creates a session token if the user doenst\'t have one' do
      expect(subject.session_token).not_to be_nil
    end
  end

  describe '#reset_session_token!' do
    it 'resets the session token' do
      old_token = subject.session_token
      subject.reset_session_token!
      expect(old_token).not_to eq(subject.session_token)
    end
  end

  describe '#password=' do
    it 'doesn\'t save the password' do
      user = User.find(subject.id)
      expect(user.password).to be_nil
    end

    it 'hashes the password' do
      password = 'abcdef'
      expect(BCrypt::Password).to receive(:create).with(password)
      User.create(username: 'blah', password: password)
    end
  end

end
