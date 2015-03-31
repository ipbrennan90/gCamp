require 'rails_helper'

describe TasksController do

  before {session[:user_id] = user.id}
  let(:user) {create_user}
  let(:project) {create_project}
  let!(:member) {member_membership}
  let!(:task) {create_task}

  describe 'GET #index' do

    it 'redirects to sign in if user not authorized' do
      session.clear
      get :index, project_id: project.id
      expect(response).to redirect_to(sign_in_path)
    end

    it 'redirects user if not project member' do
      project.memberships.destroy_all
      task
      get :index, project_id: project.id
      expect(response).to redirect_to(projects_path)
    end

    it 'populates an array of tasks if member' do
      project
      get :index, project_id: project.id
      expect(assigns(:tasks)).to eq [task]
      expect(assigns(:name)).to eq project.name
    end

  end

  describe 'GET #new' do

    it 'redirects to sign in if user not authorized' do
      session.clear
      get :new, project_id: project.id
      expect(response).to redirect_to(sign_in_path)
    end

    it 'creates a new instance of task' do
      project
      get :new, project_id: project.id
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do

    it 'reditects to sign in if user not authorized' do
      session.clear
      post :create, project_id: project.id
      expect(response).to redirect_to(sign_in_path)
    end

    it 'persists an instance of a task with valid params' do
      task = {description: 'testdescription', completed: 'false', due_date: '2015-06-04', project_id: project.id}
      post :create, project_id: project.id, task: task
      expect(assigns(:task)).to eq Task.find_by_description('testdescription')
    end

    it 'does not persist invalid '
  end
end
