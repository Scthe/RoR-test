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
		respond_to do |format|
			ok, @project = Project.create( params[:project], @user)
			if ok
				format.json {
					o = @project.attributes
					o[:url] = url_for( project_path (@project) )
					render json: o.to_json, status: :created # render json: @project, status: :created
				}
			else
				format.json { render json: @project.errors.keys, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			begin
				ok, @project = Project.update( params[:id],
											 params[:project],
											 params[:tasksToRemove][1..-2].split(",").map(&:to_i),
											 params[:peopleToRemove][1..-2].split(",").map(&:to_i),
											 params[:peopleToAdd][1..-2].split(",").map(&:to_i),
											 @user)
				if ok
					format.json {
						o = @project.attributes
						o[:url] = url_for( project_path (@project) )
						render json: o.to_json # render json: @project, status: :created
					}
				else
					format.json { render json: @project.errors.keys, status: :unprocessable_entity }
				end
			rescue ActiveRecord::RecordNotFound=>e
				format.json { render json: { :status => 'You do not have right to modify this project' }.to_json, status: :forbidden}
			rescue =>e
				format.json { render json: { :status => 'Unexpected error' }.to_json, status: :unprocessable_entity}
			end
		end
	end

	def destroy
		# TODO this should not be json..
		respond_to do |format|
			format.json { render json: { :msg => 'destroy !' }.to_json}
		end
	end

end
