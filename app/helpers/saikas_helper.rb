module SaikasHelper

  def check_saika_reservation(saikas, day, time)
    saikas.each do |saika|
      saika_day = Date.strptime(saika[:day], "%Y年%m月%d日")
      if saika[:day].present? && saika_day == day && saika[:time] == time
        return true # 予約がある場合は true を返す
      end
    end
  
    return false # 予約がない場合は false を返す
  end
  
  

  
     
end
