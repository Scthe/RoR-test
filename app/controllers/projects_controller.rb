class ProjectsController < ApplicationController

	skip_before_filter :verify_authenticity_token, :only => :create

	def index
		pip = ProjectPerson.where("user_id = ?", @user.id)
		@projects = pip.map { |e| e.project }
	end

	def show
		@project = Project.find(params[:id])
		@can_edit = true
		# TODO handle fail
	end

	def edit
		@project = Project.find(params[:id])
		@can_edit = true
	end

	def new
		@project = Project.new
	end

	#
	#forms
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



end
