class ContactMailerJob < ApplicationJob
    queue_as :default
  
    def perform(contact)
      ContactMailer.contact_send_mail(contact).deliver_now
      ContactMailer.contact_admin_mail(contact).deliver_now
    end
  end
  