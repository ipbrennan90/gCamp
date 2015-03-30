require 'rails_helper'

describe UsersController do

  describe 'GET #index' do
    it 'populates an array of users' do
      user=User.create!(first_name: "test", last_name: "tested", email: "test@test.com", password: "password", password_confirmation: "password", permission: false, pivotal_tracker_token: "141343ork4o5j5in4o3o33on")
      session[:user_id]= user.id
      get :index
      expect(assigns(:users)).to eq [user]
    end
  end

  describe 'G'
end
