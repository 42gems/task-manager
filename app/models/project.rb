class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :invites
  has_many :members, through: :invites, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title

  def not_new_tasks
    {
      'In progress' => tasks.in_progress,
      'Done'        => tasks.done,
      'Approved'    => tasks.approved
    }
  end
end
