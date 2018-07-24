class Api::V1::Accounts::RegistrationsController < ApiController

  before_filter :get_user

  def create
    unless @user.present?
      @user = User.new(user_params)
      if @user.valid?
        @user.save
        render json: { message: 'User created Successfully!', status: 200, success: true }
      else
        render json: { error: @user.errors.full_messages.first, status: 422, success: false }
      end
    else
      render json: { error: 'User already exists!', status: 422, success: false }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def get_user
    @user = User.find_by(email: params[:user][:email])
  end

end