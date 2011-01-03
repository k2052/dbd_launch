MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'dbd_launch_development'
  when :production  then MongoMapper.database = 'dbd_launch_production'
  when :test        then MongoMapper.database = 'dbd_launch_test'
end
