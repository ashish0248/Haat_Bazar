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
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @following = current_user.unfollow(@user)
    if @following.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  #ここで先にユーザーの特定

  def set_user
    @user = User.find(params[:follow_id])
  end

end
