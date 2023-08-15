class Reservation < ApplicationRecord

    def self.reservations_after_month
        # 今日から1ヶ月先までのデータを取得
        reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 1).order(day: :desc)
        # 配列を作成し、データを格納
        # DBアクセスを減らすために必要なデータを配列にデータを突っ込んでます
        reservation_data = []
          reservations.each do |reservation|
            reservations_hash = {}
            reservations_hash.merge!(day: reservation.day.strftime("%Y年%m月%d日"), time: reservation.time)
            reservation_data.push(reservations_hash)
        end
        reservation_data
      end
        
      # validates :day, presence: true
      # validates :time, presence: true
      validates :name, presence: true
      validates :email, presence: true
      validates :phone_number, presence: true
      validates :category, presence: true


       validate :modification_allowed_within_2_days, on: :update
      
            
        private  
      
     
      
        def modification_allowed_within_2_days
          if day.present? && day <= 2.days.from_now.to_date
            errors.add(:day, 'は2日前までしか修正できません')
          end
        end

        # validate :no_duplicate_reservations, on: :update

        # private
      
        # def no_duplicate_reservations
        #   if Reservation.exists?(day: day, time: '10:00') || Saika.exists?(day: day, time: '10:00')
        #     errors.add(:base, '10時の予約が既に存在します')
        #   end
      
        #   if Reservation.exists?(day: day, time: '14:00') || Saika.exists?(day: day, time: '14:00')
        #     errors.add(:base, '14時の予約が既に存在します')
        #   end
        # end

        
          validate :no_duplicate_reservation_at_10, on: :update
          validate :no_duplicate_reservation_at_14, on: :update
        
          private
        
          def no_duplicate_reservation_at_10
            if time == '10:00' && (Reservation.exists?(day: day, time: '10:00')|| Saika.exists?(day: day, time: '10:00'))
              errors.add(:time, 'はすでに予約されています')
            end
          end

          def no_duplicate_reservation_at_14
            if time == '14:00' && (Reservation.exists?(day: day, time: '14:00')|| Saika.exists?(day: day, time: '14:00'))
              errors.add(:time, 'はすでに予約されています')
            end
          end
        
        
  end
