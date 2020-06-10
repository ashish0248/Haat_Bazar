class RelationshipsController < ApplicationController
before_action :set_user, except: [:index]
	# フォロー、フォロワー一覧
    def index
      @user = User.find(current_user.id)
      @following_users = @user.followings
      @followed_users = @user.followers
    end

  def create
    @following = current_user.follow(@user)
    if @following.save
      # フォローされた側に通知
      @user.create_notification_follow!(current_user)

    else
      redirect_back(fallback_location: root_path)
    end
    # 非同期
  end

  def destroy
    @following = current_user.unfollow(@user)
    if @following.destroy
    else
      redirect_back(fallback_location: root_path)
    end
    # 非同期
  end

  private
  #ここで先にユーザーの特定

  def set_user
    @user = User.find(params[:follow_id])
  end

end

