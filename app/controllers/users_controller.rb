class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @songs = @user.songs
  end

end