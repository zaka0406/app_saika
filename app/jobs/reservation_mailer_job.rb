# app/jobs/reservation_mailer_job.rb
class ReservationMailerJob < ApplicationJob
    queue_as :default
  
    def perform(reservation)
      SaikaMailer.send_mail(reservation).deliver_now
      SaikaMailer.admin_mail(reservation).deliver_now
    end
  end
  