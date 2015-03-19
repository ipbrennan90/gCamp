def create_user
  @user1 = User.create(first_name: 'first', last_name: 'last', email: 'email@mail.com',
  password: 'securepass', password_confirmation: 'securepass')
  @user2 = User.create(first_name: 'first1', last_name: 'last1', email: 'email1@mail.com',
  password: 'securepass1', password_confirmation: 'securepass1')

end

def new_project
  @project1 = Project.create(name: 'Test Project')
end

def new_memberships(project)
  create_user
  project.memberships.create!(role: 1, project_id: @project1.id, user_id: @user1.id )
  project.memberships.create!(role: 2, project_id: @project1.id, user_id: @user2.id )
end
