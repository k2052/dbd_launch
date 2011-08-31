# Heroku ENV Vars. Don't push this to heroku, obviously. 
ENV['POSTMARK_KEY']             = 'XXXXXXXXXXXXXXXXXXXXXXXXXXX'
ENV['DEFENSIO_KEY']             = 'XXXXXXXXXXXXXXXXXXXXXXXXX'   

# S3
ENV['S3_ACCESS_KEY']            = 'XXXX'
ENV['S3_SECRET_ACCESS_KEY']     = 'XXXXX'   
ENV['S3_BUCKET']                = 'media-launch.designbreakdown.com'     

# Pass   
ENV['PASS_SALT_SECRET']         = "xxxx"         

# Twitter
ENV['TWITTER_CONSUMER_KEY']     = 'XXXXXXXXXXXXXXXXXXX'   
ENV['TWITTER_CONSUMER_SECRET']  = 'XXXXXXXXXXXXXXXXXXXXXXX'  

# VLAD/Deployment Enviroment Variables
ENV['deploy_user']      = "ubuntu"
ENV['app_name']         = "dbd_launch" 
ENV['ssh_user']         = "XXXXX" 
ENV['domain']           = "XXXXXXXXXXX" 
ENV['app_domain_name']  = "launch.designbreakdown.com"
ENV['repository']       = "ssh://#{ENV['domain']}/home/#{ENV['deploy_user']}/repos/#{ENV['app_name']}.git"
ENV['deploy_to']        = "/home/#{ENV['deploy_user']}/#{ENV['app_domain_name']}/#{ENV['app_name']}"     
ENV['nginx_site_path']  = "/etc/nginx/sites-available/#{ENV['app_domain_name']}"
ENV['deploy_via']       = "git"    
ENV['num_thin_servers'] = '2' 
ENV['thin_port']        = '3000'