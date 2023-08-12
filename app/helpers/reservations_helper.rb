module ReservationsHelper
    def times 
        times= [
            "10:00",
            "14:00",
            ]
    end
    
    def check_reservation(reservations, day, time)
      result = false
      reservations_count = reservations.count
    
      if reservations_count > 1
        reservations.each do |reservation|
          result = reservation[:day].eql?(day.strftime("%Y年%m月%d日")) && reservation[:time].eql?(time) 
          return result if result
        end

      elsif reservations_count == 1
        result = reservations[0][:day].eql?(day.strftime("%Y年%m月%d日")) && reservations[0][:time].eql?(time) 
        return result if result
      end
    
      return result
    end

   

    # require 'holidays'

    # def weekday?(date)
    #   (1..5).include?(date.wday) && !holiday?(date)
    # end
    
    # def holiday?(date)
    #   Holidays.on(date, :jp, :observed).any?
    # end
    

  end
    
