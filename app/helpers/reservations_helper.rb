module ReservationsHelper
    def times 
        times= [
            "10:00",
            "11:00",
            "13:00",
            "14:00",
            "15:00",
            ]
    end
    
    def check_reservation(reservations, day, time, name, email, phone_number)
      result = false
      reservations_count = reservations.count
    
      if reservations_count > 1
        reservations.each do |reservation|
          result = reservation[:day].eql?(day.strftime("%Y-%m-%d")) && reservation[:time].eql?(time) &&
                   reservation[:name].eql?(name) && reservation[:email].eql?(email) &&
                   reservation[:phone_number].eql?(phone_number)
          return result if result
        end
      elsif reservations_count == 1
        result = reservations[0][:day].eql?(day.strftime("%Y-%m-%d")) && reservations[0][:time].eql?(time) &&
                 reservations[0][:name].eql?(name) && reservations[0][:email].eql?(email) &&
                 reservations[0][:phone_number].eql?(phone_number)
        return result if result
      end
    
      return result
    end
  end
    
