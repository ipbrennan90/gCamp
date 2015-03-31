require 'rails_helper'


feature 'Last owner' do
  before {sign_in(user)}
  let(:user) {create_user}

  let(:project) {create_project}
  let!(:owner) {owner_membership}

  scenario 'on project cannot be changed' do

    visit project_memberships_path(project.id)
    save_and_open_page

    find_by_id("update_role").select("Member", from: 'role')


    if owner_count(project)==1
        expect(page).to have_content("You are the last owner")

    else
      page.find(:css, 'a[class="glyphicon glyphicon-remove"]').click
      expect(page).to have_content("Test Project was successfully removed")
    end
  end
end
