class SongsController < ApplicationController

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
      redirect_to @song, notice: "Song was saved successfully."
    else
      flash[:error] = "There was an error saving the song. Please try again."
      render :new
    end
  end

  def update
    @song = Song.find(params[:id])
    authorize! :update, @song, message: "Memebers can update their own songs only. Guests can't update."
    if @song.update_attributes(params[:song])
      redirect_to @song, notice: "Song was updated."
    else
      flash[:error] = "There was an error saving the song. Please try again."
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    name = @song.name
    authorize! :destroy, @song, message: "Memebers can delete their own songs only. Guests can't delete."
    if @song.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to root_url
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