class Api::V1::Users::ConnectionsController < ApiController

  def create
    @user1 = User.find_by(email: params[:friends].first)
    @user2 = User.find_by(email: params[:friends].last)
    if @user1.present? && @user2.present? 
      if @user1.friends_with?(@user2)
        render json: { success: false, error: "They're already friends!", status: 422 }
      else 
        @user1.friend_request(@user2)
        @user2.accept_request(@user1)
        render json: { success: true }
      end
    else
      if @user1.blank?
        render json: { error: "User with email #{params[:friends].first} does not exist!", success: false, status: 422 }
      else
        render json: { error: "User with email #{params[:friends].last} does not exist!", success: false, status: 422 }
      end
    end
  end

  def list_friends_for_a_user
    @user = User.find_by(email: params[:email])
    if @user.friends.any?
      render json: { success: true, friends: @user.friends, count: @user.friends.count }
    else
      render json: { success: false, error: 'No Friends', status: 422 }
    end
  end

  def mutual_friends
    @user1 = User.find_by(email: params[:friends].first)
    @user2 = User.find_by(email: params[:friends].last)
    @mutual_friends = @user1.friends & @user2.friends
    if @mutual_friends.any?
      render json: { success: true, friends: @mutual_friends, count: @mutual_friends.count }
    else
      render json: { success: false, error: 'No Mutual Friends', status: 422 }
    end
  end

end