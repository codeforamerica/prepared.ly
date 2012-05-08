class NotificationsMailer < ActionMailer::Base
  
  default :from => "feedback@prepared.ly"
  default :to => "info@prepared.ly"

  def new_message(message)
    @message = message
    mail(:subject => "[Prepared.ly] #{message.subject}")
  end

end
end
