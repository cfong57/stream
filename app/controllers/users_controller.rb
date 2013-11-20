class UsersController < ApplicationController
  #load_and_authorize_resource

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice: "Successfully created #{@user.name}." 
    else
      flash[:error] = "There was an error saving the user. Please try again."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user, message: "This user is private."
    @songs = @user.songs.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    #@tags = @user.tags.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end
  
  def index
    @users = User.visible_to(current_user).paginate(page: params[:page], per_page: 100)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated #{@user.name}."
      redirect_to @user
    else
      flash[:notice] = "There was a problem editing the user. Please try again."
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    name = @user.name
    if @user.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to root_path
    else
      flash[:error] = "There was an error deleting the user."
      render :show
    end
  end

end