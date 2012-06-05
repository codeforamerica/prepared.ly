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
    @contact = Contact.create!(params[:contact])
    @user = current_user
    @user.send_contact_form

    respond_to do |format|
      if @contact.save
        format.html { redirect_to tasks_path, notice: "Thanks, your message has been sent to a wildfire specialist." }
        #format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

end
