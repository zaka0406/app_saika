class ContactMailer < ApplicationMailer

    def contact_send_mail(contact)
        @contact = contact
        mail(to: contact.email, subject: 'お問い合わせありがとうございます')
    end

      #  管理者へ通知
      def contact_admin_mail(contact)
        @contact = contact
        mail(to: 'saikachihiro.3588@gmail.com', subject: 'お問い合わせがありました')
      end

end
