class Api::V1::Users::ConnectionsController < ApiController

  def create
    @user1 = User.find_by(email: params[:friends].first)
    @user2 = User.find_by(email: params[:friends].last)
    if @user1.present? && @user2.present? 
      if @user1.friends_with?(@user2)
        render json: { success: false, error: "They're already friends!", status: 422 }
      else
        if @user1.blocked_friends.include?(@user2)
          render json: { error: "#{@user1.email} has blocked #{@user2.email}", status: 422, success: true }
        else
          @user1.friend_request(@user2)
          @user2.accept_request(@user1)
          render json: { success: true }
        end
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

  def unblock_friends
    @user1 = User.find_by(email: params[:requestor])
    @user2 = User.find_by(email: params[:target])
    if @user1.friends_with?(@user2)
      @user1.unblock_friend(@user2)
      render json: { message: "#{@user1} has unblocked #{@user2}", success: true, status: 200 }
    else
      render json: { error: "They're already friends!", success: false, status: 422 }
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

  def block_updates_for_a_user
    @user1 = User.find_by(email: params[:requestor])
    @user2 = User.find_by(email: params[:target])
    if @user1.friends_with?(@user2)
      if @user1.block_friend(@user2)
        @subscription = Subscription.new
        @subscription.requestor_id = @user1.id
        @subscription.target_id = @user2.id
        @subscription.status = true
        @subscription.message = "#{@user1.email} has blocked #{@user2.email}"
        @subscription.save
        render json: { success: true }
      end
    else
      render json: { error: "They're not friends anymore", success: false, status: 422 }
    end
  end

  def get_list_of_emails_who_can_receive_updates
    @user = User.find_by(email: params[:sender])
    @mentioned_user = User.find_by(email: params[:text].match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)[0])
    @user.mention!(@mentioned_user)
    if @user.present?
      render json: { success: true, recipients: (@user.friends & @user.mentionees(User)) }
    else
      render json: { error: 'User does not exist!', success: false, status: 422 }
    end
  end

end