desc "This task is called by the Heroku scheduler add-on"
task :update_twitter => :environment do
  puts "Updating feed..."
  Dream.update_twitter
  puts "done."
end
