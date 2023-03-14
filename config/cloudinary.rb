require 'cloudinary'

Cloudinary.config_from_url(ENV.fetch('CLOUDINARY_URL', '<cloudinary_url_here>'))
Cloudinary.config do |config|
  config.secure = true
end
