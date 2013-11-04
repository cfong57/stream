class SongsController < ApplicationController
  
  def index
    @songs = Song.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end

  def new
    @song = Song.new
  end

  def show
    @song = Song.find(params[:id])
    authorize! :read, @song, message: "This song is private."
    #@tags = @song.tags.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    #@tag = Tag.new
  end

  def edit
    @song = Song.find(params[:id])
    authorize! :update, @song, message: "Memebers can edit their own songs only. Guests can't edit."
  end

  def create
    @song = current_user.songs.build(params[:song])
    if @song.save
      redirect_to((session[:previous_url] || root_path), notice: "Song was saved successfully.")
    else
      flash[:error] = "There was an error saving the song. Please try again."
      render :new
    end
  end

  def update
    @song = Song.find(params[:id])
    authorize! :update, @song, message: "Memebers can update their own songs only. Guests can't update."
    if @song.update_attributes(params[:song])
      redirect_to((session[:previous_url] || root_path), notice: "\"#{@song.name}\" was updated successfully.")
    else
      flash[:error] = "There was an error saving the song. Please try again."
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    authorize! :destroy, @song, message: "Memebers can delete their own songs only. Guests can't delete."
    if @song.destroy
      redirect_to((session[:previous_url] || root_path), notice: "\"#{@song.name}\" was deleted successfully.")
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

end