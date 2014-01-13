namespace :db do
  task :wipe_db => :environment do
    User.destroy_all
    Song.destroy_all
    puts "Destroyed all users and songs."
  end
end