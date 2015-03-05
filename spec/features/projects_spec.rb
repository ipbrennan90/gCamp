require 'rails_helper'


  feature 'Projects' do
    before do
      sign_in
      @project1 = Project.create(name: 'Test Project')
    end


    scenario 'User creates a new project' do
      visit new_project_path
      fill_in :project_name, with: 'Testing Project'
      click_on 'Create Project'
      expect(page).to have_content('Project was successfully created')
      expect(page).to have_content('Testing Project')
    end

    scenario 'User can see a project when clicking on linked name' do
      visit projects_path
      click_on "Test Project"
      expect(page).to have_content('Test Project')
    end

    scenario 'User can edit project' do
      visit project_path(@project1)
      click_on 'Edit'
      fill_in :project_name, with: 'Newer Project'
      click_on 'Update Project'
      expect(page).to have_content('Project was successfully updated')
      expect(page).to have_content('Newer Project')

    end

    scenario 'User can delete project' do
      visit project_path(@project1)
      click_on "Delete"
      expect(page).to have_no_content('Test Project')
    end

    scenario 'User cannot add project without name' do
      visit new_project_path
      fill_in :project_name, with: ""
      click_on 'Create Project'
      expect(page).to have_content("can't be blank")
    end

  end
