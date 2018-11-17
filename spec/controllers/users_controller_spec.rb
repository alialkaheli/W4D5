require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "controller#new" do 
    it "render new page" do 
      get :new 
      expect(response).to render_template(:new)
    end
  end 
  
  describe "controller#create" do 
    context "valid user" do
      it "log in user" do 
        post :create, params: {user: {username: "mike", password: "password"}}
        user = User.find_by_credentials("mike", "password")
        expect(user.session_token).to eq(session[:session_token]) 
      end 
      
      it "redirect user" do
        post :create, params: {user: {username: "mike", password: "password"}}
        user = User.find_by_credentials("mike", "password")
        expect(response).to redirect_to(user_url(user))
      end
    end
    
    context "invalid user" do 
      it "checks for errors" do
        post :create, params: {user: {username: "mike", password: "p"}}
        expect(response).to render_template(:new) 
        expect(flash[:errors]).to be_present
      end
    end 
  end
  
  describe "controller#show" do 
    it "render to a user page" do
      User.create!(username: "mike", password: "password")
      get :show, params: {id: User.last.id}
      expect(response).to render_template(:show) 
    end
  end
  
  
end
