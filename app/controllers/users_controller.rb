class UsersController < ApplicationController
  #load_and_authorize_resource
  helper_method :sort_column, :sort_direction

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
    #current_ability defaults to read
    @songs = Song.accessible_by(current_ability).where('user_id = ?', @user.id).
    order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    #@tags = @user.tags.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end
  
  def index
    #current_ability defaults to read
    @users = User.accessible_by(current_ability).order(sort_column + ' ' + sort_direction).
    paginate(page: params[:page], per_page: 10)
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

  private

  #technically there should be one for User model too
  #but the only important things to sort on are attributes with identical names in Song, so...
  #SQL injection type tampering could create broken queries but it shouldn't do anything
  def sort_column
    Song.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "asc"
  end

end