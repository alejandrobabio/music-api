require File.expand_path('../config/environment', __FILE__)

use Rack::Static,
  root: File.expand_path('../swagger-ui', __FILE__),
  urls: ["/assets"],
  index: 'index.html'

run MusicAPI::Base
