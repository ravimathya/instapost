class FollowsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_user

    def create
        current_user.follow(@user)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end

    def destroy
        current_user.unfollow(@user)
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end


    private

    def find_user
        @user = User.find(params[:user_id])
    end



end
