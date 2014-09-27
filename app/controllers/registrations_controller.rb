class RegistrationsController < Devise::RegistrationsController

  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    params[:user].permit!
    build_resource params[:user]

    if resource.save
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        return render :json => {:success => true, :url => url_for( dashboard_path )}
      else
        expire_session_data_after_sign_in!
        return render :json => {:success => true, :url => url_for( dashboard_path )}
      end
    else
      clean_up_passwords resource
      return render :json => {:success => false}
    end
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

end
