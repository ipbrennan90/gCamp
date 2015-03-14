namespace :cleanup do
  desc 'removes memberships when user deleted'
    task removes_memberships: :environment do
      existing_users=User.pluck(:id)
      Membership.where.not(user_id: existing_users).destroy_all
    end

  desc 'removes memberships when project deleted'
    task removes_projectless_members: :environment do
      existing_projects= Project.pluck(:id)
      Membership.where.not(project_id: existing_projects).destroy_all
    end

  desc 'removes all tasks when project deleted'
    task removes_projectless_tasks: :environment do
      existing_projects= Project.pluck(:id)
      Task.where.not(project_id: existing_projects).destroy_all
    end

  desc 'removes all comments where tasks deleted'
    task removes_taskless_comments: :environment do
      existing_tasks= Task.pluck(:id)
      Comment.where.not(task_id: existing_tasks).destroy_all
    end

  desc 'Set user_id to nil on comment if user deleted'
    task set_id_to_nil_when_user_deleted: :environment do
      existing_users=User.pluck(:id)
      Comment.where.not(user_id: existing_users) do
        Comment.user_id = nil
      end
    end
  desc 'removes any task with null project_id'
    task remove_task_with_null_preject_id: :environment do
      Task.where(project_id: nil).destroy_all
    end

  desc 'removes comments with null task_id'
    task remove_comment_with_null_task: :environment do
      Comment.where(task_id: nil).destroy_all
    end

  desc 'removes memberships with null project or user id'
    task remove_membership_with_null_project_or_user: :environment do
      Membership.where("project_id = ? or user_id = ?", nil, nil).destroy_all
    end


end
