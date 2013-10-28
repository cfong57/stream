class TagsController < ApplicationController

  def new
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
    authorize! :read, @song, message: "This tag is private."
    @songs = @tag.songs.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    @song = Song.new
  end

  def edit
    @tag = Tag.find(params[:id])
    authorize! :update, @tag, message: "Memebers can edit their own tags only. Guests can't edit."
  end

  def create
    @tag = current_user.tags.build(params[:tag])
    if @tag.save
      redirect_to @tag, notice: "Tag was saved successfully."
    else
      flash[:error] = "There was an error saving the tag. Please try again."
      render :new
    end
  end

  def update
    @tag = Tag.find(params[:id])
    authorize! :update, @tag, message: "Memebers can update their own tags only. Guests can't update."
    if @tag.update_attributes(params[:tag])
      redirect_to @tag, notice: "Tag was updated."
    else
      flash[:error] = "There was an error saving the tag. Please try again."
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    name = @tag.name
    authorize! :destroy, @tag, message: "Memebers can delete their own tags only. Guests can't delete."
    if @tag.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to root_url
    else
      flash[:error] = "There was an error deleting the tag."
      render :show
    end
  end
end