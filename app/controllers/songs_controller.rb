class SongsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    #current_ability defaults to read
    if params[:tag]
      @songs = Song.accessible_by(current_ability).tagged_with(params[:tag]).
      order(sort_column + ' ' + sort_direction).
      paginate(page: params[:page], per_page: 10)
    else
      @songs = Song.accessible_by(current_ability).order(sort_column + ' ' + sort_direction).
      paginate(page: params[:page], per_page: 10)
    end
  end

  def new
    @song = Song.new
  end

  def show
    @song = Song.find(params[:id])
    authorize! :read, @song, message: "This song is private."
  end

  def edit
    @song = Song.find(params[:id])
    authorize! :update, @song, message: "Memebers can edit their own songs only. Guests can't edit."
  end

  def create
    @song = Song.new(params[:song])

    #allows guests to upload, since can't .songs.build off a non-user
    @song.update_attribute(:user, current_user)

    if @song.save
      redirect_to(@song, notice: "Song was saved successfully.")
    else
      flash[:error] = "There was an error saving the song. Please try again."
      render :new
    end
  end

  def update
    @song = Song.find(params[:id])
    authorize! :update, @song, message: "You can't edit a song that doesn't belong to you. Guests can't edit."
    if @song.update_attributes(params[:song])
      redirect_to(proper_redirect_path_for(@song), notice: "\"#{@song.name}\" was updated successfully.")
    else
      flash[:error] = "There was an error saving the song. Please try again."
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    authorize! :destroy, @song, message: "Memebers can delete their own songs only. Guests can't delete."
    if @song.destroy
      if(proper_redirect_path_for(@song).match("\/songs\/[0-9]+"))
        #ugly hack to redirect to userpage if song was deleted from its show view
        #kind of arbitrary choice, would be "best" to send to "wherever they were before viewing song"
        redirect_to(current_user, notice: "\"#{@song.name}\" was deleted successfully.")
      else
        #otherwise, send to wherever user was last at
        redirect_to(proper_redirect_path_for(@song), notice: "\"#{@song.name}\" was deleted successfully.")
      end
    else
      flash[:error] = "There was an error deleting the song."
      render :show
    end
  end

  #probably don't need this ever
  def preview
    song = Song.new(params[:song])
    render :text => song.audio_html
  end

  def anonymous
<<<<<<< HEAD
    if params[:tag]
      @anonymous_songs = Song.where(user_id: nil).tagged_with(params[:tag]).
      order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    else
      @anonymous_songs = Song.where(user_id: nil).
      order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    end
=======
    @anonymous_songs = Song.where(user_id: nil).order(sort_column + ' ' + sort_direction).
    paginate(page: params[:page], per_page: 10)
>>>>>>> tagging
  end

  private

  def sort_column
    Song.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    if(["asc", "desc"].include?(params[:direction]))
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end

end