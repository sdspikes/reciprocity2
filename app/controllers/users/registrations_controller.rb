class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def create
    @user = User.new(user_params)

  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit!
      # devise_parameter_sanitizer.for(:sign_up).push(:name, :phone, :organization)
    end
end
