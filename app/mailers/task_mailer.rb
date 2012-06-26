class TaskMailer < ActionMailer::Base
  default from: "notifications@prepared.ly"

  def reminder_email(opts = {})
    @user = opts[:user]
    @task = opts[:task]
    attachments.inline['preparedly-red.png'] = File.read('app/assets/images/preparedly-red.png')
    mail(:to => @user.email, :subject => "Task Reminder")
  end
end