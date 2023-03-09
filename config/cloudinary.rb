require 'cloudinary'

Cloudinary.config_from_url(ENV.fetch('CLOUDINARY_URL'))
Cloudinary.config do |config|
  config.secure = true
end
