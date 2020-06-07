class HomesController < ApplicationController
  def top
  	@user_makers = User.where(user_maker: true)
  	@user_shops = User.where(user_maker: false)
  end

  def index
  	@user_makers = User.where(user_maker: true)
  	@user_shops = User.where(user_maker: false)
  	# タグ検索
  	if params[:tag_name]
      @users = User.tagged_with("#{params[:tag_name]}")
      @user_makers = @users.where(user_maker: true)
      @user_shops = @users.where(user_maker: false)
    end
  end

  def about
  end

  def new
  end
end
