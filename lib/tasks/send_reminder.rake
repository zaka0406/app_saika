namespace :send_reminder do
    desc "Send reminder emails to clients"
    task :send_email => :environment do
        ENV['RAILS_ENV'] = 'production'
      begin
        puts "Starting send_email task..."
        # environmentを読み込んだり、タスクをロードする必要はありません
        
        reservations = Reservation.where("day = ?", Date.tomorrow)
        reservations.each do |reservation|
          puts "Processing reservation #{reservation.id}"
          ReservationMailer.send_reminder(reservation).deliver_now
          puts "Sent email to #{reservation.email}"
        end
        puts "Finished send_email task."
      rescue => e
        puts "Error: #{e.message}"
        puts e.backtrace
      end
    end
  end
  