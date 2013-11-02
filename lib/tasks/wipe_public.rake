namespace :db do
  task :wipe_public => :environment do
    #destroy public songs 1 week old or more
    limit = 604800
    pre = Song.where(:user_id => nil).count
    Song.where(:user_id => nil).destroy_all("created_at < '#{Time.now - limit}'")
    post = Song.where(:user_id => nil).count
    puts "Deleted all public songs older than #{limit} seconds."
    puts "#{pre} songs before, #{post} songs after (#{pre - post} diff)"
  end
end