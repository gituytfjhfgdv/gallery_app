module UserAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
  end

  private

  def authenticate_user
    redirect_to login_path unless session[:user_id].present?
  end
end
