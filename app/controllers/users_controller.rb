class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize! :read, @user, message: "This user is private."
    @songs = @user.songs.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    #@tags = @user.tags.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end

end