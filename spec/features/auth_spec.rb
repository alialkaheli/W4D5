require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  User.destroy_all
  User.create!(username: 'mike', password: 'password')
  
  background :each do 
    visit new_user_path
  end 
  
  scenario 'has a new user page' do
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      User.destroy_all
      fill_in 'Username', with: 'mike'
      fill_in 'Password', with: 'password'
      click_button 'Sign Up'
      expect(page).to have_content('mike')
      user = User.find_by(username: 'mike')
      expect(current_path).to eq(user_path(user))
    end

  end
end

feature 'logging in' do
  background :each do 
    visit new_session_path
  end 
  
  scenario 'shows username on the homepage after login' do
    fill_in 'Username', with: 'mike'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    expect(page).to have_content('mike')
    user = User.find_by(username: 'mike')
    expect(current_path).to eq(user_path(user)) 
  end

end

feature 'logging out' do
  background :each do 
    visit new_session_path
  end 
  
  scenario 'begins with a logged out state' do 
    expect(page).to have_content('Sign Up') 
  end 

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).not_to have_content('mike') 
  end
end