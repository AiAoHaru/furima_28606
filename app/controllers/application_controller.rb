class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index] #ログイン済みか判断し、ログインしていないユーザーに対して、サインアップ画面に遷移させるための記述。
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:nickname, :family_name, :last_name, :family_name_reading, :last_name_reading, :birth_date])
  end
end
