class ApplicationController < ActionController::Base
  before_action :basic_auth

  before_action :authenticate_user!, except: [:index] #ログイン済みか判断し、ログインしていないユーザーに対して、サインアップ画面に遷移させるための記述。
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:nickname, :family_name, :last_name, :family_name_reading, :last_name_reading, :birth_date])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'password'
    end
  end
end
