require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it{is_expected.to have_many(:tasks).dependent(:destroy)}

  it{ is_expected.to validate_presence_of(:email)}
  it{ is_expected.to validate_uniqueness_of(:email).case_insensitive}
  it{ is_expected.to validate_confirmation_of(:password)}
  it{ is_expected.to allow_value('marks88martinez@gmail.com').for(:email)}
  it{ is_expected.to validate_uniqueness_of(:auth_token) }

  describe "#info" do
    it "returns email, and created_at a token" do
      user.save!

      allow(Devise).to receive(:friendly_token).and_return('abc123xzyTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xzyTOKEN")

    end

  end

  describe "#generate_authentication_token!" do
    it "generate a unique auth token" do
      allow(Devise).to receive(:friendly_token).and_return('abc123xzyTOKEN')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xzyTOKEN')
    end
    it "generates another auth token the current auth token already has bee token" do

      allow(Devise).to receive(:friendly_token).and_return('abc123xzytokenzxc','abc123xzytokenzxc','abc123456789')
      existing_user = create(:user)
        user.generate_authentication_token!
        expect(user.auth_token).not_to eq(existing_user.auth_token)
    end

  end



  # it{expect(user).to respond_to(:email)}
  # context "when name is blank" do
  #   before {user.name = " "}
  #
  #   it {expect(user).not_to be_valid}
  #
  # end
  #
  # context "when name is nil" do
  #   before {user.name = " "}
  #
  #   it {expect(user).not_to be_valid}
  #
  # end

  # it {expect(user).to validate_presence_of(:name)}

  # subject { build(:user) }
  # pending "add some examples to (or delete) #{__FILE__}"
  # before{@user = FactoryGirl.build(:user)}
  #
  # it{expect(@user).to respond_to(:email)}
  # it{expect(@user).to respond_to(:name)}
  # it{expect(@user).to respond_to(:password)}
  # it{expect(@user).to respond_to(:password_confirmation)}
  # it{expect(@user).to be_valid}

  # it{expect(subject).to respond_to(:email)}
  # it{expect(subject).to be_valid}
  # it {is_expected.to respond_to(:email)}


end
