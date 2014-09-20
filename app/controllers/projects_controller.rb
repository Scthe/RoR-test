class ProjectsController < ApplicationController

	skip_before_filter :verify_authenticity_token, :only => :create
	set_page_type :projects

	def index
		@projects = Project.projects_for_user( @user)
	end

	def show
		begin
			@project = Project.find_(params[:id], @user)
			@can_edit = true
		rescue ActiveRecord::RecordNotFound=>e
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
	end

	def edit
		# TODO add new person
		begin
			@project = Project.find_(params[:id], @user)
		rescue ActiveRecord::RecordNotFound=>e
			render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
		end
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
