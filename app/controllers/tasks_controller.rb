class TasksController < ApplicationController

	# TODO add comments as inner resource

	def index
	end

	def show
		# TODO does not contain link back to project ?
		@task = Task.find(params[:id])
		@can_edit = true
		@canAddComment = true
	end

	def edit
		@task = Task.find(params[:id])
		pip = ProjectPerson.where("project_id = ?", @task.project.id)
		@people_to_assign = pip.map { |e| e.user }
	end

	def new
		@project = Project.find(0) # TODO should use params[:project_id] !
		@task = Task.new
		pip = ProjectPerson.where("project_id = ?", @project.id)
		@people_to_assign = pip.map { |e| e.user }
	end

	#
	# forms
	def create
		# p params[:project]
		respond_to do |format|
			format.json { render json: { :msg => 'seems ok' }.to_json}
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
