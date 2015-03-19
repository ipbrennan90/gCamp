require 'rails_helper'


feature 'Last owner' do

  scenario 'on project cannot be removed' do
    Membership.destroy_all
    new_project
    @memberships = new_memberships(@project1)

    visit project_memberships_path(@project1)

    if owner_count(@project1)==1
        all(:css, 'a[class="glyphicon glyphicon-remove"]')[0].click
        save_and_open_page
        expect(page).to have_content("Projects much have at least one owner")
    else
      page.find(:css, 'a[class="glyphicon glyphicon-remove"]').click
      expect(page).to have_content("Test Project was successfully removed")
    end
  end
end
