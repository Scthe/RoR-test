class TasksController < ApplicationController

	set_page_type :tasks

	def index
	end

	def show
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
		@project = Project.find(0)
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
			begin
				ok, @task = Task.update( params[:id], params[:task], @user)
				if ok
					format.json {
						o = @task.attributes
						o[:url] = url_for( task_path (@task) )
						render json: o.to_json
					}
				else
					format.json { render json: @task.errors.keys, status: :unprocessable_entity }
				end
			rescue ActiveRecord::RecordNotFound=>e
				format.json { render json: { :status => 'You do not have right to modify this task' }.to_json, status: :forbidden}
			rescue =>e
				format.json { render json: { :status => 'Unexpected error' }.to_json, status: :unprocessable_entity}
			end
		end
	end

	def destroy
		respond_to do |format|
			begin
				@task = Task.find_(params[:id], @user)
				@task.destroy
				o = { :url => url_for( tasks_path ) }
				format.json { render json: o.to_json}
			rescue ActiveRecord::RecordNotFound=>e
				format.json { render json: { :status => 'Unexpected error' }.to_json, status: :unprocessable_entity}
			end
		end
	end

	def add_comment # TODO add comment
		respond_to do |format|
			format.json { render json: { :msg => 'comment add !' }.to_json}
		end
	end

end
