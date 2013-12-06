class UsersController < ApplicationController
  #load_and_authorize_resource

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, notice: "Successfully created #{@user.name}." 
    else
      flash[:error] = "There was an error saving the user. Please try again."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user, message: "This user is private."
    @songs_alphabetical = @user.songs.alphabetical.paginate(page: params[:page], per_page: 10)
    @songs_recent = @user.songs.recent.paginate(page: params[:page], per_page: 10)
    #@tags = @user.tags.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end
  
  def index
    @users_alphabetical = User.alphabetical.paginate(page: params[:page], per_page: 10)
    @users_uploads = User.uploads.paginate(page: params[:page], per_page: 10)
    @users_recent = User.recent.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "\"#{@user.name}\" was updated successfully."
      redirect_to @user
    else
      flash[:notice] = "There was a problem editing the user. Please try again."
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    name = @user.name
    if @user.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to users_path
    else
      flash[:error] = "There was an error deleting the user."
      render :show
    end
  end

end