seeds = {"slap chop" => "http://www.youtube.com/watch?v=JCZ13jm7wQI", 
  "chinese electric pokemon" => "http://www.youtube.com/watch?v=jD-aww5bmug",
"falling through the sun" => "http://www.youtube.com/watch?v=8Fi4aVrbtvc",
"nanaya x shiki" => "http://www.youtube.com/watch?v=8ZRqjLv19_I",
"dazzle card capture test" => "http://www.youtube.com/watch?v=onEE8Uu8vME",
"gae bolg" => "http://www.youtube.com/watch?v=f6AYN8JQLrM",
"nanaya x ryougi" => "http://www.youtube.com/watch?v=vv6ArLTfVOM",
"tsubame gaeshi" => "http://www.youtube.com/watch?v=CSsaROCeubs"}

pub = User.public_user

seeds.keys.size.times do |x|
  pub.songs.create(name: seeds.keys[x], info: Faker::Song.paragraph, audio: seeds.values[x])
end

u = User.new(
  name: 'Admin User',
  email: 'admin@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Member User',
  email: 'member@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

puts "Seed finished, created admin and user, put songs in public pool"