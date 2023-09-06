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
        @selection = params[:selection]
        session[:selected_selection] = params[:selection]
        @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
        # @start_time = DateTime.parse(@day.to_s + " " + @time.to_s + " " + "JST")
        # @start_time = DateTime.parse(@day.to_s + " " + @time.gsub("～", "") + " JST")


        
       end

    def back
        @reservation = Reservation.new(session[:reservation])
        redirect_to new_reservation_path(day: @reservation.day, time: @reservation.time, name: @reservation.name, email: @reservation.email, phone_number: @reservation.phone_number, category: @reservation.category,selection: @reservation.selection)
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

        editing_reservation_id = session[:editing_reservation_id]
        if @reservations.present? || editing_reservation_id.present?
          render :search
        else
          redirect_to no_reservation_reservations_path
        end
      end
      
  
      def show
        @reservation = Reservation.find(params[:id])
         editing_reservation_id = session[:editing_reservation_id]
        if editing_reservation_id.present?
          @reservation = Reservation.find(editing_reservation_id)
        end
      end
      

    def no_reservation
    end
    
    def edit
      @reservation = Reservation.find(params[:id])
      session[:editing_reservation_id] = @reservation.id
    end
    
    def create
      @reservation = Reservation.new(session[:reservation])
    
      if @reservation.save
        ReservationMailerJob.perform_later(@reservation) # メール送信ジョブをキューに追加
        
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

       # 保存が成功したかどうかを確認
        if @reservation.save
          EditReservationMailerJob.perform_later(@reservation) 
          # 修正が成功した場合、メール送信ジョブをキューに追加
       # 保存に成功した場合の処理
        
         else
        # 保存に失敗した場合の処理
         render :edit
        end

      end
       
      
      
      
      def destroy
        @reservation = Reservation.find(params[:id])
        if @reservation.destroy
          SaikaMailer.deletion_send_mail(@reservation).deliver_now
          SaikaMailer.deletion_admin_mail(@reservation).deliver_now
          
          flash[:notice] = "予約は削除されました"

        else
          flash[:alert] = "予約の削除に失敗しました"
        end
        redirect_to reservations_path
      end
         
    

    # 安全なデータなのか確認するためにストロングパラメーターとして設定
    private
        def reservation_params
            params.require(:reservation).permit(:day, :time, :name, :email, :phone_number, :category, :selection, :start_time,:accepted)
        end

        def set_reservation
             @reservation = Reservation.find(params[:id])
        end

        def deletable_reservation?(reservation)
          # 予約日が今日の日付より後かつ、予約日前日の午前中までの場合にtrueを返す
          reservation.day > Date.current && reservation.day <= (Date.current + 1.day).at_beginning_of_day
        end
        

end
