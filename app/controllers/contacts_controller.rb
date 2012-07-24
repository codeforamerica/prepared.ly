class ContactsController < ApplicationController
 before_filter :authenticate_user!
 
  def new
    @contact = Contact.new
    respond_to do |format|
      format.html #new.html.erb
      format.json { render json: @contact }
    end
  end

  def create
    @contact = Contact.new(params[:contact])
    @user = current_user

    if @contact.save
      @user.send_contact_form
      redirect_to root_path, :flash => {:alert => "Thanks, your message has been sent to a wildfire specialist." }
    end
  end

end
