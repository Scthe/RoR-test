class Task < ActiveRecord::Base
  belongs_to :project_id
  belongs_to :personResponsible
  belongs_to :created_by
end
