class TaskComment < ActiveRecord::Base

	belongs_to :task
	belongs_to :user
	validates :text, length: { maximum: 140 }

end
