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


        validate :valid_time_selection, on: :update
        validate :no_booking_at_10_if_data_present, on: :update
        validate :no_booking_at_14_if_data_present, on: :update
        validate :booking_allowed_if_other_slot_available, on: :update
        validate :modification_allowed_within_2_days, on: :update
      
            
        private
      
        def valid_time_selection
          unless ['10:00', '14:00'].include?(time) && !new_record?
            errors.add(:time, 'は10時か14時を選択してください') 
          end
        end
      
        def no_booking_at_10_if_data_present
          if time == '10' && Reservation.exists?(day: day, time: '10') && !new_record?
            errors.add(:time, 'はすでに予約されています')
          end
        end
      
        def no_booking_at_14_if_data_present
          if time == '14' && Reservation.exists?(day: day, time: '14') && !new_record?
            errors.add(:time, 'はすでに予約されています')
          end
        end
      
        def booking_allowed_if_other_slot_available
          if time == '10' && Reservation.exists?(day: day, time: '14') && !new_record?
            errors.add(:time, 'は14時に空きがある場合のみ予約できます')
          elsif time == '14' && Reservation.exists?(day: day, time: '10') && !new_record?
            errors.add(:time, 'は10時に空きがある場合のみ予約できます')
          end
        end
      
        def modification_allowed_within_2_days
          if day.present? && day <= 2.days.from_now.to_date
            errors.add(:day, 'は2日前までしか修正できません')
          end
        end
      
        validate :no_duplicate_time_slot, on: :create

        def no_duplicate_time_slot
          if Reservation.exists?(day: day, time: ['10:00', '14:00']) || Saika.exists?(day: day, time: ['10:00', '14:00'])
            errors.add(:base, '10時または14時の予約が既に存在します')
          end
        end

end
