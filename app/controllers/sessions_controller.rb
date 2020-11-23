class SessionsController < ApplicationController
  before_action :user, only: :create
  before_action :permit_only_valid_user, only: :create

  def new
    @sign_in_params ||= { email: '', password: '' }
    @errors ||= []
  end

  def create
    login(@user)
    redirect_to photos_path
  end

  def destroy
    logout
  end

  private

  def sign_in_params
    params.require(:session).permit(:email, :password)
  end

  def permit_only_valid_user
    @sign_in_params = sign_in_params
    errors_messages
    unless @user&.authenticate(@sign_in_params[:password]) && @errors.blank?
      render :new
      return
    end
  end

  def errors_messages
    @errors = []
    @errors << 'ユーザidを入力してください' if @sign_in_params[:email].blank?
    @errors << 'パスワードを入力してください' if @sign_in_params[:password].blank?
    return unless @user.blank? && @sign_in_params[:email].present? && @sign_in_params[:password].present?

    @errors << '入力された情報で登録されたユーザが見つかりませんでした。'
  end

  def user
    @user = User.find_by_email(sign_in_params[:email])
  end
end
