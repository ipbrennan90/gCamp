require 'rails_helper'

  feature 'Users' do

    before do
      new_user
    end

    scenario 'user can sign up' do
      visit root_path
      click_on 'Sign Up'
      expect(page).to have_content("Sign up for gCamp!")
      fill_in :user_first_name, with: 'first1'
      fill_in :user_last_name, with: 'last1'
      fill_in :user_email, with: 'email1@email1.com'
      fill_in :user_password, with: 'securepass1'
      fill_in :user_password_confirmation, with: 'securepass1'
      click_on 'Sign up'
      expect(current_path).to eq '/'
      expect(page).to have_content("You have successfully signed up")
      expect(page).to have_content('first1 last1')
      expect(page).to have_no_content( 'Sign Up')
    end

    scenario 'logged in users can see project, tasks, and users' do
      sign_in
      expect(current_path).to eq '/'
      click_on 'Projects'
      expect(page).to have_content('Projects')
      click_on 'Tasks'
      expect(page).to have_content('Tasks')
      click_on 'Users'
      expect(page).to have_content('Users')

    end


    scenario 'Users can signout' do
      visit root_path
      sign_in
      click_on 'Sign out'
      expect(page).to have_content('You have successfully logged out Sign in ')
      expect(page).to have_no_content('Sign out')
      expect(current_path).to eq '/'


    end

    scenario 'Users can sign in with valid credentials' do
      sign_in
      expect(page).to have_content("You have successfully signed in")
      expect(current_path).to eq '/'
    end

    scenario 'Users cannot sign in with invalid credentials' do
      @user1.update_attributes(password: 'differentpassword' )
      sign_in

      expect(page).to have_content("Email / Password combination is invalid")
      expect(current_path).to eq '/sign-in'
    end

  end
