require 'rails_helper'

describe MembershipsController do

  before {session[:user_id] = user.id}
  let(:user) {create_user}
  let(:project) {create_project}
  let(:member) {member_membership}
  let(:owner) {owner_membership}

  describe 'GET #index' do
    xit 'populates an array of memberships' do
      member
      get :index, project_id: project.id
      expect(assigns(:memberships)).to eq([member])
      expect(assigns(:name)).to eq project.name
    end
  end
end
