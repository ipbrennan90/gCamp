require 'rails_helper'

describe TasksController do

  before {session[:user_id] = user.id}
  let(:user) {create_user}
  let(:project) {create_project}
  let!(:member) {create_membership}
  let!(:task) {create_task}

  describe 'GET #index' do

    it 'populates an array of tasks' do
      get :index, project_id: project.id
      expect(assigns(:tasks)).to eq [task]
      expect(assigns(:name)).to eq project.name
    end

  end

  describe 'GET #new' do

    it 'creates a new instance of task' do
      get :new, project_id: project.id
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do

    it 'persists an instance of a task with valid params' do
      task_hash = {description: 'testdescription', completed: 'false', due_date: '2015-06-04', project_id: project.id}
      post :create, project_id: project.id, task: task_hash
      expect(assigns(:task)).to eq Task.find_by_description('testdescription')
    end

    it 'does not persist instance of task with invalid params' do
      task_hash = {description: nil , completed: 'false', due_date: '2015-06-04', project_id: project.id}
      post :create, project_id: project.id, task: task_hash
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'finds task' do
      get :edit, project_id: project.id, id: task.id
      expect(assigns(:task)).to eq(task)
    end

  end

  describe 'GET #show' do
    it 'finds task' do
      get :show , project_id: project.id, id: task.id
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'PUT #update' do

    it 'persists valid changes' do
      put :update, project_id: project.id, id: task.id, task: {description: "new description"}
      expect(task.reload.description).to eq("new description")
    end

    it 'does not persist invalid changes' do
      put :update, project_id: project.id, id: task.id, task: {description: nil}
      task.reload
      expect(task.description).to eq('Test Task')
    end

  end

  describe 'DELETE #destroy' do
    it 'destroys a task' do
      expect {delete :destroy, project_id: project.id, id: task.id}.to change{Task.all.count}.by(-1)
    end
  end

  describe 'unauthorized users get redirected' do

    before {session.clear}

    it 'if get action' do

      actions = [:index, :new, :edit, :show]
      actions.each do |action|
        get action, project_id: project.id, id: task.id

        expect(response).to redirect_to(sign_in_path)
      end
    end

    it 'if put action' do
      put :update, project_id: project.id, id: task.id, task: {description: "description"}

      expect(response).to redirect_to(sign_in_path)
    end

    it 'if post action' do
      post :create, project_id: project.id, id: task.id

      expect(response).to redirect_to(sign_in_path)
    end

    it 'if delete action' do
      delete :destroy, project_id: project.id, id: task.id

      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe 'non-owner members get redirected' do
    before {project.memberships.destroy_all}
    before {task}

    it 'if  get action' do

      actions = [:index, :show, :edit]
      actions.each do |action|
        get action, project_id: project.id, id: task.id

        expect(response).to redirect_to(projects_path)
      end
    end

    it 'if put action' do

      put :update, project_id: project.id, id: task.id, task: {description: "description"}

      expect(response).to redirect_to(projects_path)
    end

    it 'if delete action' do

      delete :destroy, project_id: project.id, id: task.id

      expect(response).to redirect_to(projects_path)
    end


  end



end
