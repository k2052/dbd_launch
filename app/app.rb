class DbdLaunch < Padrino::Application 
  
  ##
  # Intializers
  #
  
  # Core
  register Padrino::Helpers   
  register NavvyInitializer  
    
  # Resources. JS, CSS handling ext
  register CompassInitializer 
  require 'sinatra/minify'   
  register Sinatra::Minify    

  ##
  # App Settings 
  #
  
  # Sinatra Minify
  if Padrino.env == :production  
    set :public_url, "http://assets0-launch.designbreakdown.com/css"       
    set :css_url, 'http://assets0-launch.designbreakdown.com/css'
    set :js_url, "http://assets0-launch.designbreakdown.com/js" # => http://site.com/js  
  else   
    set :css_url, '/css' # => http://site.com/js 
    set :js_url, '/js' # => http://site.com/js                
  end
  set :js_path, '../public/js' # => ~/myproject/public/js
  set :css_path, '../public/css'
  set :minify_config, '../config/assets.yml'
end