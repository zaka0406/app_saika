class ContactController < ApplicationController
    def new
      @contact = Contact.new
      session.delete(:contact)
      @name = params[:name]
      @email = params[:email]
      @phone_number = params[:phone_number]
      @message = params[:message]
    end
  
    # 入力内容確認用
    def confirm
      @contact = Contact.new(contact_params)
      # ここでストロングパラメータの情報を代入している
      session[:contact] = @contact
      Rails.logger.debug "Session: #{session[:contact].inspect}"
      render :new if @contact.invalid?
    end
  
    def back
      @contact = Contact.new(session[:contact])
      redirect_to new_contact_path(name: @contact.name, email: @contact.email, phone_number: @contact.phone_number, message: @contact.message)
      session.delete(:reservation)
    end
    
  
    def create
      @contact = Contact.new(session[:contact])
      if @contact.save
        # ContactMailerJob.perform_later(@contact) #メール送信非同期化
          ContactMailer.contact_send_mail(@contact).deliver_later
          ContactMailer.contact_admin_mail(@contact).deliver_later
      else
        render :new
      end
    end
  
    
    private
  
    def contact_params
      params.require(:contact).permit(:name, :email, :phone_number, :message)
                   
    end
end
