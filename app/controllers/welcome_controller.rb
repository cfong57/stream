class WelcomeController < ApplicationController
  def index
  end

  def about
  end

  def public
    @pub = User.public_user
    @public_songs = @pub.songs.paginate(page: params[:page], per_page: 10)
  end
end
