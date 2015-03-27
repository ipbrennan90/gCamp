require 'rails_helper'


feature 'Last owner' do

  scenario 'on project cannot be removed' do
    sign_in
    Membership.destroy_all
    new_project
    @memberships = new_memberships(@project1)

    visit project_memberships_path(@project1)
    save_and_open_page

    if owner_count(@project1)==1
        expect(page).to have_content("You are the last owner")

    else
      page.find(:css, 'a[class="glyphicon glyphicon-remove"]').click
      expect(page).to have_content("Test Project was successfully removed")
    end
  end
end
