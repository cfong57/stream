class Tag < ActiveRecord::Base
  belongs_to :song
  attr_accessible :name, :value, :public

  default_scope order('updated_at DESC')
  scope :visible_to, lambda { |user| user == current_user ? scoped : joins(:tag).where('tag.public = true') }

  validates :name, presence: true 
  validates :value, presence: true

  #value would be e.g.
  #name = "nsfw"
  #value = true
  #it is of type text, to allow e.g. name = "background" value = "wall of text about african tribal drum songs"
  #for ones that should be integer or boolean, parsing out the correct value will be done accessor-side
  #length = song.tags["length"].to_i
  #(or whatever, don't think it works that way)
  #this does require certain standardized naming conventions for some tags, though...
  #maybe "reserve" certain tag names that will be used for metadata, to prevent users overwriting them accidentally?

end
