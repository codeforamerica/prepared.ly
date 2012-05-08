class ContactController < ApplicationController
    def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:message])
    
    if @feedback.valid?
      NotificationsMailer.new_message(@feedback).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
end
