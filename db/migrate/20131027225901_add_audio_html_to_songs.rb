class AddAudioHtmlToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :audio_html, :text
  end
end
