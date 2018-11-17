require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user1) {User.create!(username: "mike2", password: "password2")}
  
  context "validations" do 
    it {should validate_presence_of :username }
    it {should validate_presence_of :password_digest }
    it {should validate_presence_of :session_token }
    it {should validate_length_of(:password).is_at_least(6)}
    it {should validate_uniqueness_of :username}
  end 
  
  describe "User::find_by_credentials" do 
    it "finds the user " do 
      mike = User.create!(username: "mike", password: "password")
      user = User.find_by_credentials("mike","password")
      expect(mike.username).to eq(user.username)
    end 
  end 
  
  describe "User::session_token" do
    it "assigns a token to a User" do
      mike = User.create!(username: "mike", password: "password")
      expect(mike.session_token).not_to be_nil
    end
  end
  
  
end
