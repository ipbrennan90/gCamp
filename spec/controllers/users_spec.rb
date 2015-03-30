require 'rails_helper'

describe UsersController do

  before do
    session[:user_id] = user.id
  end

  let(:user) {User.create!(first_name: "test", last_name: "tested", email: "test@test.com", password: "password", password_confirmation: "password", permission: false, pivotal_tracker_token: "141343ork4o5j5in4o3o33on")}

  describe 'GET #index' do
    it 'populates an array of users' do
      get :index
      expect(assigns(:users)).to eq [user]
    end
  end

  describe 'GET #new' do
    it 'creates a new instance' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #create' do
    it 'creates an instance of user' do
      bob = User.new
      get :create
      expect(assigns(:user)
    end
  end



end
