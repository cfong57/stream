# IF want to experiment with cloud uploading later. Probably won't use for a while.
# Need a different gem than Carrierwave anyway (audio, not images)

# Adding Amazon S3 to Carrierwave
#CarrierWave.configure do |config| 
#  config.fog_credentials = { 
#    :provider               => 'AWS', 
#    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'], 
#    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY']
    #region: 'us-west-2',
    #endpoint: 'https://s3-us-west-2.amazonaws.com'
#  } 
#  config.fog_directory  = ENV['AWS_BUCKET']
#  config.fog_public     = false 
#end 

# Ref:
# https://support.cloud.engineyard.com/entries/20996881-Use-CarrierWave-and-Optionally-Fog-to-Upload-and-Store-Files#update3
# http://stackoverflow.com/questions/7946819/carrierwave-and-amazon-s3