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
      
      validates :day, presence: true
      validates :time, presence: true
      validates :name, presence: true
      validates :email, presence: true
      validates :phone_number, presence: true
      validates :category, presence: true
      
    
end
