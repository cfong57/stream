class WelcomeController < ApplicationController
  def index
  end

  def about
  end

  def anonymous
    @anonymous_songs = Song.where(user_id: nil).paginate(page: params[:page], per_page: 10)
  end
end
