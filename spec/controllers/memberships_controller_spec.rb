require 'rails_helper'

describe MembershipsController do

  User.destroy_all
  before {session[:user_id] = user.id}
  let(:user1) { create_user(email: "bob@test.com") }
  let(:user) {create_user}
  let(:project) {create_project}
  let(:member) {create_membership({user_id: user1.id, role: 2})}
  let!(:owner) {create_membership}

  describe 'GET #index' do
    it 'populates an array of memberships' do
      get :index, project_id: project.id

      expect(assigns(:memberships)).to eq(project.memberships.all)
      expect(assigns(:name)).to eq project.name
    end
  end

  describe 'GET #new' do
    it 'creates a new membership instance' do
      get :new, project_id: project.id
      expect(assigns(:membership)).to be_a_new(Membership)
    end
  end

  describe 'POST #create' do
    it 'persists an instance of a membership with valid params' do
      member_new = { user_id: user1.id, role: 1}

      post :create, project_id: project.id, membership: member_new

      expect(assigns(:membership)).to eq Membership.last
    end

    it 'does not persist instance of membership with invalid params' do

      bad_membership = {project_id: nil, user_id: nil, role: nil}

      post :create, project_id: project.id, membership: bad_membership

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #update' do
    it 'persists valid changes' do
      put :update, project_id: project.id, id: member.id, membership: {role: 1}

      expect(member.reload.role).to eq(1)
    end

    it 'does not persist invalid changes' do
      put :update, project_id: project.id, id:member.id, membership: {user_id: nil}
      member.reload
      expect(member.user_id).to eq(user1.id)
    end

    it 'does not persist if changing last owner role' do
      post :update, project_id: project.id, id:owner.id, membership: {role: 2}
      expect(owner.role).to eq(1)
    end

  end

  describe 'DELETE #destroy' do
    before{member}

    it 'destroys a membership' do
      expect {delete :destroy, project_id: project.id, id: member.id}.to change {Membership.all.count}.by(-1)
    end

    it 'does not destroy last owner' do
      expect {delete :destroy, project_id: project.id, id: owner.id}.to change {Membership.all.count}.by(0)
    end
  end

  describe 'members get redirected' do
    before{project.memberships.destroy_all}

    it 'because index requires user to have owner membership' do
      get :index, project_id: project.id

      expect(response).to redirect_to(project_path(project))
    end

    it 'because create requires users to be owner' do
      post :create , project_id: project.id, id: member.id, membership: {user_id: user1.id, role: 2}

      expect(response).to redirect_to(project_path(project))
    end

    it 'because update requires users to be owner' do
      put :update, project_id: project.id, id: member.id, membership: {role: 1}

      expect(response).to redirect_to(project_path(project))
    end

    it 'because destroy requires users to be owner' do
      delete :destroy, project_id: project.id, id: member.id

      expect(response).to redirect_to(project_path(project))      
    end
  end


end
