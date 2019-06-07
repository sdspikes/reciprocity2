class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    puts 'in facebook method in the OmniauthCallbacksController'
    puts request.env["omniauth.auth"]

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      # PrivacyGroup.create_facebook_group(@user.facebook_token) if Facebook.get_object(@user.facebook_token, "me")
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
