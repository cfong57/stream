class Tag < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :songs
  attr_accessible :name, :value, :public

  default_scope order('updated_at DESC')
  scope :visible_to, lambda { |user| user == current_user ? scoped : joins(:tag).where('tag.public = true') }

  validates :name, presence: true 

  #value would be e.g.
  #name = "nsfw"
  #value = true
  #it is of type text, to allow e.g. name = "background" value = "wall of text about african tribal drum songs"

end
