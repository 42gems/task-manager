class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy

  STATES = {
    todo: 'new',
    in_progress: 'in progress',
    done: 'done',
    approved: 'approved'
  }

  validates_presence_of  :title, :state
  validates_inclusion_of :state, in: STATES.values, message: 'state can be only new/in progress/done/approved'

  scope :open, -> { where("state = ? OR state = ?", 'new', 'in progress') }
  
  STATES.each do |key, val|
    scope key, -> { where state: val }
  end
end
