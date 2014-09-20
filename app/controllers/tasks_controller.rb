class TasksController < ApplicationController

	# TODO add comments as inner resource
	set_page_type :tasks

	def index
	end

	def show
		# TODO does not contain link back to project ?
		begin
			@task = Task.find_(params[:id], @user)
			@can_edit = true
			@canAddComment = true
		rescue ActiveRecord::RecordNotFound=>e
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	def edit
		begin
			@task = Task.find_(params[:id], @user)
			@people_to_assign = @task.project.users
		rescue ActiveRecord::RecordNotFound=>e
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	def new
		@project = Project.find(0) # TODO should use params[:project_id] !
		@task = Task.new
		@people_to_assign = @project.users
	end

	#
	# forms
	def create
		respond_to do |format|
			ok, @task = Task.create( params[:task], @user)
			if ok
				format.json {
					o = @task.attributes
					o[:url] = url_for( task_path (@task) )
					render json: o.to_json, status: :created # render json: @task, status: :created
				}
			else
				format.json { render json: @task.errors.keys, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			format.json { render json: { :msg => 'update !' }.to_json}
		end
	end

	def destroy
		# TODO this should not be json..
		respond_to do |format|
			format.json { render json: { :msg => 'destroy !' }.to_json}
		end
	end

	def add_comment
		respond_to do |format|
			format.json { render json: { :msg => 'comment add !' }.to_json}
		end
	end

end
