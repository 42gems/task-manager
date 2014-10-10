class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invites
  has_many :members, through: :invites, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title
  validates_length_of :description, maximum: 255

  def not_new_tasks
    {
      'In progress' => tasks.in_progress,
      'Done'        => tasks.done,
      'Approved'    => tasks.approved
    }
  end

  def select_users_for_invites
    user_ids = Invite.where(project_id: self.id).pluck(:user_id) << self.owner.id
    users = nil
    unless user_ids.empty?
      users = User.where.not('id IN (?)', user_ids)
    else
      users = User.where.not(id: self.owner.id)
    end
    users.map do |user|
      [
        user.email,
        user.id,
        email: user.email,
        'data-project-url' => Rails.application.routes.url_helpers.project_send_invite_path(self, user)
      ]
    end
  end
end
