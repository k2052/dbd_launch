require 'lemonade' 
sass_dir = "app/stylesheets"
project_type = :stand_alone
http_path = "/"
css_dir = "public/css" 
images_dir = "public/images" 
output_style = :compressed     
relative_assets  = false     
asset_host do |asset|
  "http://assets%d-launch.designbreakdown.com" % (asset.hash % 4)
end