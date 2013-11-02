namespace :db do
  task :wipe_db => :environment do
    User.destroy_all
    Song.destroy_all
    Tag.destroy_all
    puts "Destroyed all users, songs, and tags."
  end
end