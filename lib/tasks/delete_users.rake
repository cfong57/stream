namespace :db do
  task :delete_users => :environment do
    User.destroy_all
  end
end