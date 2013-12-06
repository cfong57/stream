class Song < ActiveRecord::Base
  belongs_to :user
  #has_and_belongs_to_many :tags
  attr_accessible :name, :audio, :info, :public

  #mount_uploader :audio, SongUploader
  #maybe later

  scope :alphabetical, ->{order('name ASC')}
  scope :recent, ->{order('created_at DESC')}

  def alphabetical
    @songs = Song.alphabetical
  end

  def recent
    @songs = Song.recent
  end

  #two different users might pick the exact same name for a song, if it's generic
  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :audio, presence: true  

  auto_html_for :audio do
    html_escape
    image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end