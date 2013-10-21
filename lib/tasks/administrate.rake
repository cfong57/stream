namespace :db do
  task :administrate => :environment do
    beater = User.where('name LIKE ?', "%Kirito%").first
    if(beater.nil?)
      u = User.new(
      name: "Kirito",
      email: "kirito@sao.com", 
      password: "mottohayaku", 
      password_confirmation: "mottohayaku")
      u.skip_confirmation!
      u.save
      u.update_attribute(:role, 'admin')
      puts "Created Kirito."
    else
      beater.update_attribute(:email, 'kirito@sao.com')
      beater.update_attribute(:password, 'mottohayaku')
      beater.update_attribute(:role, 'admin')
      puts "Kirito already exists!"
   end
  end
end