# Whenever sSchedule file. 
# See https://github.com/javan/whenever    

every 1.day, at => '4:35 am' do
  command "cd /home/ubuntu/launch.designbreakdown.com/dbd_launch && bundle exec padrino rake backup:runit trigger='mongodb-backup-s3' "
end