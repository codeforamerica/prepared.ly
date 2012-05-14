desc "This task is called by the Heroku scheduler add-on"
task :scheduler_test => :environment do
    puts "running a scheduled test..."
    puts "done."
end

task :send_scheduled_sms_messages => :environment do
    puts "Sending scheduled sms messages"
    Message.send_scheduled_messages
    puts "done."
end
