class ReservationsController < ApplicationController

    def index
        @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 1).order(day: :desc)
    end

    def new
        @reservation = Reservation.new
        session.delete(:reservation)
        @day = params[:day]
        @time = params[:time]
        @name = params[:name]
        @email = params[:email]
        @phone_number = params[:phone_number]
        @category = params[:category]
        @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
        # @start_time = DateTime.parse("#{@day} #{@time}")
    end

    def back
        @reservation = Reservation.new(session[:reservation])
        # render("reservations/new")
        redirect_to new_reservation_path(day: @reservation.day, time: @reservation.time, name: @reservation.name, email: @reservation.email, phone_number: @reservation.phone_number, category: @reservation.category)
        session.delete(:reservation)
        return
    end
      

    def confirm
        @reservation = Reservation.new(reservation_params)
        session[:reservation] = @reservation
        if @reservation.invalid?
           render :new
        end
    end
      
  
    def show
        @reservation = Reservation.find(params[:id])
    end
    
    def create
        @reservation = Reservation.new(session[:reservation])
        if @reservation.save
            # redirect_to("/")
            # flash[:notice] = "予約が完了されました"
        else
            render :new
        end
    end
    
    def reservation_params
        params.require(:reservation).permit(:day, :time, :name, :email, :phone_number, :category, :start_time)
    end

end
