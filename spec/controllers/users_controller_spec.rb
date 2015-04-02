require 'rails_helper'

describe UsersController do

  before do
    session[:user_id] = user.id
  end

  let(:user) {create_user}


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

  describe 'POST #create' do
    it 'persists an instance of user' do
      bob = { first_name: "bob", last_name: "bobbers", email: "bob@bobby.com", password: "password"}
      post :create, user: bob

      expect(assigns(:user)).to eq User.find_by_first_name("bob")
      expect(response).to redirect_to(users_path)
    end

    it 'does not persist an invalid user' do
      bob = { first_name: nil, last_name: "bobbers", email: "bob@bobby.com", password:"password"}
      post :create, user: bob
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'finds user' do
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #edit' do
    it 'renders 404 if not current user' do
      not_user = User.create!(first_name: "not", last_name: "user", email: "not_user@test.com", password: "password", password_confirmation: "password", permission: false, pivotal_tracker_token: "141343ork4o5j5in4o3o33on")
      session.clear
      session[:user_id] = not_user.id
      get :edit, id: user
      expect(response.status).to eq(404)
    end

    it 'finds user to edit' do
      get :edit, id: user
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT #update' do


    it 'persists valid changes' do
      put :update, id: user.id,  user: {first_name: "test1"}
      expect(user.reload.first_name).to eq "test1"
    end

    it 'does not persist invalid changes' do
      put :update, id: user.id, user: {first_name: nil}
      expect(user.reload.first_name).to eq "test"
    end
  end

  describe 'DELETE #destroy' do
    before {user}
    it 'ends session' do
      delete :destroy, id: user
      expect(session[:user_id]).to eq(nil)
    end

    it 'destroys user instance' do
      expect {delete :destroy, id: user}.to change{User.all.count}.by(-1)
    end
  end
end
