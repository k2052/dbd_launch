# Whenever sSchedule file. 
# See https://github.com/javan/whenever    

every 2.hours do
  command "cd /home/ubuntu/launch.designbreakdown.com/dbd_launch && bundle exec padrino rake backup:runit trigger='mongodb-backup-s3' "
end