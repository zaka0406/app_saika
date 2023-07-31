class SampleMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.send_mail.subject
  #
  def send_mail
    @greeting = "Hi"

    mail to: "to@example.org"
  end

    # #  お客様へ通知
    # def send_mail(reservation)
    #   @reservation = reservation
    #   mail(to: reservation.email, subject: 'ご予約ありがとうございました')
    # end
  
    # #  管理者へ通知
    # def admin_mail(reservation)
    #   @reservation = reservation
    #   mail(to: 'zaka0406@gmail.com', subject: '予約が入りました')
    # end
  
end
