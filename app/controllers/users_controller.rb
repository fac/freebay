class UsersController < Clearance::UsersController

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      flash.now.alert = "Please complete all the fields"
      render template: "users/new"
    end
  end


  protected

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def user_from_params
      User.new(user_params)
    end
end