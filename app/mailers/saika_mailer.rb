class SaikaMailer < ApplicationMailer

     #  お客様へ通知
     def send_mail(reservation)
        @reservation = reservation
        mail(to: reservation.email, subject: 'ご予約ありがとうございました')
      end
    
      #  管理者へ通知
      def admin_mail(reservation)
        @reservation = reservation
        mail(to: 'saikachihiro.3588@gmail.com', subject: '予約が入りました')
      end

      # 修正用
      def edit_send_mail(reservation)
        @reservation = reservation
        mail(to: reservation.email, subject: '予約の修正を承りました')
      end

      #  修正用　管理者へ通知
      def edit_admin_mail(reservation)
        @reservation = reservation
        mail(to: 'saikachihiro.3588@gmail.com', subject: '予約が修正されました')
      end

        # キャンセル用
        def deletion_send_mail(reservation)
          @reservation = reservation
          mail(to: reservation.email, subject: '予約のキャンセルを承りました')
        end
  
        #  修正用　管理者へ通知
        def deletion_admin_mail(reservation)
          @reservation = reservation
          mail(to: 'saikachihiro.3588@gmail.com', subject: '予約がキャンセルされました')
        end
    
        # カウンセリング前日のリマインダーメールを送信するメソッド
        def send_reminder(reservation)
          @reservation = reservation
          mail(to: reservation.email, subject: 'カウンセリング前日のご案内')
        end

        def send_admin_reminder(reservation)
          @reservation = reservation
          mail(to: 'saikachihiro.3588@gmail.com', subject: 'カウンセリング前日です')
        end
end