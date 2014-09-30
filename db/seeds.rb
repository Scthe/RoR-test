require 'active_record/fixtures'
fs = ['users', 'projects', 'tasks', 'task_comments', 'projectPerson']
fs.each do |f|
	ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", f )
end