class SaikasController < ApplicationController
    
    before_action :saika_reservation, only: [:admin,:new,:create]
 

    def index
    end
    
    def about
    end

    def service
    end
    
    def admin
        @saika =  Saika.saikas_after_month
        @day = params[:day]
        @time = params[:time]
    end
      
    def new
        @saika = Saika.new
        @day = params[:day]
        @time = params[:time]
        @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
    end

    def create
             @saika = Saika.new(saika_params)
        
            if @saika.save(validate: false)
          # 保存が成功したら別のページにリダイレクト
                redirect_to admin_saikas_path
            else
          # 保存が失敗した場合は新規作成ページを表示
                render :new
            end

    end

    private

   def saika_params
      params.require(:saika).permit(:day, :time, :start_time)
    end

    def saika_reservation
        @reservations = Reservation.where(day: params[:day], time: params[:time])
    end
end
