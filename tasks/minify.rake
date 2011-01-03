# Takes the js in config/assets.yml and minifys them into singular files.
task :minify => :environment do
  puts "Building..."
  files = Sinatra::Minify::Package.build(DbdLaunch)  # <= change this
  files.each { |f| puts " * #{File.basename f}" }
  puts "Construction complete!"
end