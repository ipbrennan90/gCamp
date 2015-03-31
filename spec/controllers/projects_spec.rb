require 'rails_helper'

describe ProjectsController do

  before do
    session[:user_id] = user.id
  end

  let(:user) {User.create!(first_name: "test", last_name: "tested", email: "test@test.com", password: "password", password_confirmation: "password", permission: false, pivotal_tracker_token: "652dfc58f4f25cd5bfc7ecbd6f303245")}
  let(:project) {Project.create!(name: "ProjectTest")}

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
    



end
