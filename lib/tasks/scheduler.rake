desc "This task is called by the Heroku scheduler add-on"
task :scheduler_test => :environment do
    puts "running a scheduled test..."
    puts "done."
end
