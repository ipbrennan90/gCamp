require 'rails_helper'

describe ProjectsController do

  before {session[:user_id] = user.id}
  let!(:user) {create_user}
  let(:project) {create_project}
  let(:owner) { create_membership }
  let!(:member) {create_membership(role: 2)}

  describe 'GET #index' do

    before{project}
    it 'populates an array of projects' do
      get :index
      expect(assigns(:projects)).to eq user.projects
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
    it 'persists an instance of project' do
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
      member
      get :edit, id: project.id
      expect(response).to redirect_to(project_path(project))
    end

    it 'finds project to edit if user is owner' do
      owner
      user.reload
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe 'PUT #update' do
    it 'redirects users who are not owners' do
      member
      put :update, id: project.id, project: {name: "ProjectTest1"}
      expect(response). to redirect_to(project_path(project))
      expect(project.name).to eq('ProjectTest')
    end

    it 'persists valid changes for owner' do
      owner
      put :update, id: project.id, project: {name: "ProjectTest1"}
      project.reload
      expect(project.name).to eq('ProjectTest1')
    end

    it 'persists valid changes for admin' do
      user.update_attributes(permission: true)
      put :update, id: project.id, project: {name: 'ProjectTest2'}
      project.reload
      expect(project.name).to eq('ProjectTest2')
    end

  end

  describe 'DElETE #destroy' do
    it 'redirects users who are not owners' do
      member
      delete :destroy, id: project
      expect(response). to redirect_to(project_path(project))
    end

    it 'destroys a project if user owner' do
      owner
      expect {delete :destroy, id:project}.to change{Project.all.count}.by(-1)
    end
  end

end
