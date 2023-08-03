class EditReservationMailerJob < ApplicationJob
    queue_as :default
  
    def perform(reservation)
      SaikaMailer.edit_send_mail(reservation).deliver_now
      SaikaMailer.edit_admin_mail(reservation).deliver_now
    end
    
  end