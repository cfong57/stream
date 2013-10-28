namespace :db do
  task :wipe_db => :environment do
    User.destroy_all
    Song.destroy_all
    Tag.destroy_all
  end
end