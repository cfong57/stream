class Song < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :audio, :info, :public, :tag_list

  acts_as_taggable

  #mount_uploader :audio, SongUploader
  #maybe later

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