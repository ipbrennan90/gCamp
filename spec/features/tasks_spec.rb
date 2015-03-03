require 'rails_helper'


  feature 'Tasks' do
    before do
      @task1 = Task.create(description: 'Test Task', due_date: '2015-03-04')
    end


    scenario 'User creates a new task' do
      visit new_task_path
      fill_in :task_description, with: 'New Task'
      fill_in :task_due_date, with: '2015-03-04'
      click_on 'Create Task'
      expect(page).to have_content('Task has been created')
      expect(page).to have_content('New Task')
      expect(page).to have_content('Due On: 03/04/2015')
    end

    scenario 'User can see a task when clicking on linked name' do
      visit task_path(@task1)
      expect(page).to have_content('Test Task Due On: 03/04/2015')
    end

    scenario 'User can edit task' do
      visit task_path(@task1)
      click_on 'Edit'
      fill_in :task_description, with: 'Newer Task'
      click_on 'Update Task'
      expect(page).to have_content('Task was successfully updated.')
      expect(page).to have_content('Newer Task')

    end

    scenario 'User can delete task' do
      visit tasks_path
      click_on "Delete"
      expect(page).to have_no_content('Test Task')
    end

    scenario 'User cannot add task without description' do
      visit new_task_path
      fill_in :task_due_date, with: '2015-03-04'
      click_on 'Create Task'
      expect(page).to have_content("Description can't be blank")
    end

  end
