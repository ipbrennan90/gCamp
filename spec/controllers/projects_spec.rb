require 'rails_helper'

describe ProjectsController do

  before {session[:user_id] = user.id}
  let(:user) {User.create!(first_name: "test", last_name: "tested", email: "test@test.com", password: "password", password_confirmation: "password", permission: false, pivotal_tracker_token: "652dfc58f4f25cd5bfc7ecbd6f303245")}
  let(:project) {Project.create!(name: "ProjectTest")}
  let(:owner_membership) {Membership.create!(project_id: project.id, user_id: user.id, role: 1) }
  let(:member_membership) {Membership.create!(project_id: project.id, user_id: user.id, role: 2)}

  describe 'GET #index' do
    it 'populates an array of projects' do
      project
      get :index
      expect(assigns(:projects)).to eq [project]
    end

    before do
      @tracker_api = TrackerAPI.new
    end

    it 'populates an array of tracker projects with valid token' do
      tracker_projects = @tracker_api.projects(user.pivotal_tracker_token)
      expect(tracker_projects[0][:name]).to eq "gCamp - Ian Brennan"
    end

    it 'raises error when token invalid' do
      tracker_projects = @tracker_api.projects("103u419492305u09823r2n4294004inf")
      expect(tracker_projects[:error]).to eq("Invalid authentication credentials were presented.")
    end
  end

  describe 'GET #new' do
    it 'creates a new instance of project' do
      project
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe 'POST #create' do
    it 'persists an instance of project' do \
      project = {name: "testproject"}
      post :create, project: project
      expect(assigns(:project)).to eq Project.find_by_name("testproject")
    end

    it 'does not persist an invalid project' do
      project = {name: nil}
      post :create, project: project
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'redirects to projects if user not owner' do
      member_membership
      get :edit, id: project.id
      expect(response).to redirect_to(projects_path)
    end

    it 'finds project to edit if user is owner' do
      owner_membership
      get :edit, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'PUT #update' do
    it 'redirects users who are not owners' do
      put :update, id: project.id, project: {name: "ProjectTest1"}
      expect(response). to redirect_to(projects_path)
    end
  end

end
