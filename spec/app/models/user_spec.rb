require 'spec_helper'

describe User do

  it "validates user email" do
    emails = %w{mail@mail.com mail@mail.borg adfafafadfa}
    users = []
    3.times do |i|
      users << Fabricate.build(:user, email: emails[i]).valid?
    end

    expect(users[0]).to eq true
    expect(users[1]).to eq false
    expect(users[2]).to eq false
  end

  describe '#generate_api_token' do
    let(:user) { Fabricate.build(:user) }

    it 'assigns a hex api token' do
      user.send(:generate_api_token)
      expect(user.api_token).to match /^[a-f\d]{32}$/
    end

    context 'with argument' do
      it 'assigns token with specific length' do
        user.send(:generate_api_token, 10)
        expect(user.api_token.size).to eq 20
      end
    end
  end

  describe '.authenticate' do
    before { Fabricate(:user) }

    it 'returns nil if user does not exist' do
      expect(User.find_by_email('user@domain.com')).to eq nil
      expect(User.authenticate('user@domain.com', 'password')).to eq nil
    end

    it 'returns nil if password does not match' do
      user = User.authenticate('john@doe.com', 'password')
      expect(user).to eq nil
    end

    it 'returns nil if email does not match' do
      user = User.authenticate('bro@doe.com', 'mypassword')
      expect(user).to eq nil
    end

    it 'returns user instance' do
      user = User.authenticate('john@doe.com', 'mypassword')
      expect(user).to be_a User
    end
  end

  describe 'before save' do
    context 'when new record' do
      let(:user) { Fabricate.build(:user) }

      it 'generates api token' do
        expect(user.api_token).to eq nil
        user.save
        expect(user.api_token).to match /^[a-f\d]{32}$/
      end

      it 'generate perishable token' do
        expect(user.perishable_token).to eq nil
        user.save
        expect(user.perishable_token).not_to eq nil
      end
    end

    context 'when password is set' do
      let(:user) { Fabricate.build(:user, password: nil, password_confirmation: nil) }

      it 'generates password salt and encrypts password' do
        expect(user.password_hash).to eq nil
        expect(user.password_salt).to eq nil

        user.password = 'password'
        user.password_confirmation = 'password'

        user.save

        expect(user.password_hash).to be_a String
        expect(user.password_salt).to be_a String
      end
    end
  end
end