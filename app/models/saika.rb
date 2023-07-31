class Saika < ApplicationRecord
    def self.saikas_after_month
        # 今日からずっと先までのデータを取得
        saikas = Saika.where("day >= ?", Date.current).order(day: :desc)
        # 配列を作成し、データを格納
        # DBアクセスを減らすために必要なデータを配列にデータを突っ込んでます
        saika_data = []
        saikas.each do |saika|
          saika_hash = {}
          saika_hash.merge!(day: saika.day.strftime("%Y年%m月%d日"), time: saika.time)
          saika_data.push(saika_hash)
        end
        saika_data
    end
end      
