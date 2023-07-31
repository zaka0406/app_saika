class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:edit]

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
        session[:selected_category] = params[:category]
        @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
       end

    def back
        @reservation = Reservation.new(session[:reservation])
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

    def check
    end

    def search
        @reservations = Reservation.where(name: params[:name], email: params[:email], phone_number: params[:phone_number])
                                    .where("day >= ?", Date.current)
                                    .order(day: :desc)

        if @reservations.present?
          render :seach
        else
          redirect_to no_reservation_reservations_path
        end
      end
      
  
    def show
        @reservations = Reservation.where(name: params[:name], email: params[:email], phone_number: params[:phone_number])
                        .where("day >= ?", Date.current)
                        .order(day: :desc)
    end

    def no_reservation
    end
    
    def edit
    end
    
    def create
        @reservation = Reservation.new(session[:reservation])
        if @reservation.save
     
        else
            render :new
        end
    end
   
    def update
        @reservation = Reservation.find(params[:id])
        # フォームから送信されたデータで更新する
        @reservation.assign_attributes(reservation_params)

       # 日付と時間を文字列からDateTimeオブジェクトに変換する
        start_time = DateTime.parse("#{@reservation.day} #{@reservation.time}")
      
        # start_time を設定する
        @reservation.start_time = start_time
        @reservation.save
    
      end
       
      
      
      
      def destroy
        @reservation = Reservation.find(params[:id])
        if @reservation.destroy
          flash[:notice] = "予約は削除されました"
        else
          flash[:alert] = "予約の削除に失敗しました"
        end
        redirect_to reservations_path
      end
         
    

    # 安全なデータなのか確認するためにストロングパラメーターとして設定
    private
        def reservation_params
            params.require(:reservation).permit(:day, :time, :name, :email, :phone_number, :category, :start_time,:accepted)
        end

        def set_reservation
             @reservation = Reservation.find(params[:id])
        end

        def deletable_reservation?(reservation)
          # 予約日が今日の日付より後かつ、予約日前日の午前中までの場合にtrueを返す
          reservation.day > Date.current && reservation.day <= (Date.current + 1.day).at_beginning_of_day
        end
        

end
