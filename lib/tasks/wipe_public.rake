namespace :db do
  task :wipe_public => :environment do
    #destroy public songs 1 week old or more
    limit = Time.now - 604800
    Song.where(:user => nil).destroy_all("created_at < '#{limit}'")
  end
end