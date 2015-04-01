require 'rails_helper'


  feature 'Tasks' do

    before {sign_in(user)}
    let(:user) {create_user}
    let(:project) {create_project}
    let!(:owner) {create_membership}
    let!(:task) {create_task}



    scenario 'User creates a new task' do

      visit new_project_task_path(project)
      fill_in :task_description, with: 'New Task'
      fill_in :task_due_date, with: '2015-06-04'
      click_on 'Create Task'
      expect(page).to have_content('Task has been created')
      expect(page).to have_content('New Task')
      expect(page).to have_content('06/04/2015')
    end

    scenario 'User can see a task when clicking on linked name' do
      visit project_tasks_path(project)
      click_on task.description
      expect(page).to have_content('Test Task Due On: 06/04/2015')
    end

    scenario 'User can edit task' do
      visit project_task_path(project, task)
      click_on 'Edit'
      fill_in :task_description, with: 'Newer Task'
      click_on 'Update Task'
      expect(page).to have_content('Task was successfully updated.')
      expect(page).to have_content('Newer Task')

    end

    scenario 'User can delete task' do
      visit project_tasks_path(project)
      page.find(:css, 'a[class="glyphicon glyphicon-remove"]').click
      expect(page).to have_no_content('Test Task')
    end

    scenario 'User cannot add task without description' do
      visit new_project_task_path(project)
      fill_in :task_due_date, with: '2015-06-04'
      click_on 'Create Task'
      expect(page).to have_content("Description can't be blank")
    end

  end
