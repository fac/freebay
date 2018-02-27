class UsersController < Clearance::UsersController

  protected

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

    def user_from_params
      User.new(user_params)
    end
end