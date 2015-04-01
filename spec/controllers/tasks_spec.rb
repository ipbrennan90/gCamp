require 'rails_helper'

describe TasksController do

  before {session[:user_id] = user.id}
  let(:user) {create_user}
  let(:project) {create_project}
  let!(:member) {member_membership}
  let!(:task) {create_task}

  describe 'GET #index' do

    it 'populates an array of tasks if member' do
      project
      get :index, project_id: project.id
      expect(assigns(:tasks)).to eq [task]
      expect(assigns(:name)).to eq project.name
    end

  end

  describe 'GET #new' do

    it 'creates a new instance of task' do
      project
      get :new, project_id: project.id
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do

    it 'persists an instance of a task with valid params' do
      task = {description: 'testdescription', completed: 'false', due_date: '2015-06-04', project_id: project.id}
      post :create, project_id: project.id, task: task
      expect(assigns(:task)).to eq Task.find_by_description('testdescription')
    end

    it 'does not persist instance of task with invalid params' do
      task = {description: nil , completed: 'false', due_date: '2015-06-04', project_id: project.id}
      post :create, project_id: project.id, task: task
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'finds project' do
      get :edit, project_id: project.id, id: task.id
      expect(assigns(:task)).to eq(task)

  end

  describe 'unauthorized users get redirected' do

    it 'redirects unauthorized users to sign in' do
      session.clear
      actions = [:index, :new, :create, :edit, :show, :update, :destroy]
      actions.each do |action|
        if action== :index || :new || :edit || :show
          get action, project_id: project.id, id: task.id
        elsif action == :update
          put action, project_id: project.id, id: task.id, task: {description: "description"}
        elsif action == :create
          post action, project_id: project.id, id: task.id
        else
          delete action, project_id: project.id, id: task.id
        end
        expect(response).to redirect_to(sign_in_path)
      end
    end

  end

  describe 'members get redirected' do

    it 'if action requires user to have owner membership' do
      project.memberships.destroy_all
      task
      actions = [:index, :show, :edit, :update, :destroy]
      actions.each do |action|
        if action== :index || :edit || :show
          get action, project_id: project.id, id: task.id
        elsif action == :update
          put action, project_id: project.id, id: task.id, task: {description: "description"}
        else
          delete action, project_id: project.id, id: task.id
        end
        expect(response).to redirect_to(projects_path)
      end
    end

  end



end
