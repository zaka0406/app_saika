# app/jobs/deletion_reservation_mailer_job.rb
class DeletionReservationMailerJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    SaikaMailer.deletion_send_mail(reservation).deliver_now
    SaikaMailer.deletion_admin_mail(reservation).deliver_now
  end
end
