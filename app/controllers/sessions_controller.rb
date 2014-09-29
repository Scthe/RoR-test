class SessionsController < Devise::SessionsController

	protect_from_forgery with: :null_session
	
	# per:
	# http://stackoverflow.com/questions/20875591/actioncontrollerinvalidauthenticitytoken-in-registrationscontrollercreate
	# https://github.com/plataformatec/devise/issues/2432#issuecomment-18973236
	# skip_before_filter :verify_authenticity_token, :only => :create

	# POST /users/sign_in
	def create
		resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
		sign_in_and_redirect(resource_name, resource)
	end

	#
	def sign_in_and_redirect(resource_or_scope, resource=nil)
		scope = Devise::Mapping.find_scope!(resource_or_scope)
		resource ||= resource_or_scope
		sign_in(scope, resource) unless warden.user(scope) == resource
		return render :json => {:success => true, :url => url_for( dashboard_path ) }
	end

	def failure
		return render :json => {:success => false, :errors => ["Login failed."]}
	end

end
