class SaikasController < ApplicationController
    
    before_action :saika_reservation, only: [:admin,:new,:create]
 

    def index
        @blogs = Blog.order(created_at: :desc).limit(10)
    end
    
    def about
    end

    def service
    end

    def show_blog
        @blog = Blog.find(params[:id])
        @blog_dates = extract_dates_and_contents(@blog.content)
      end

    # def show_blog
    #     @blog = Blog.find(params[:id])
    #     if @blog.url
    #       redirect_to @blog.url
    #     else
    #       # もしurlがNULLの場合、特定のURLにリダイレクト
    #       redirect_to "https://ameblo.jp/chi-harusora"
    #     end
    #   end
      
    
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

    def extract_dates_and_contents(content)
        # 正規表現を使って日付とコンテンツを抽出
        regex = /(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\n(.*?)\n/
        matches = content.scan(regex)
        
        # 日付とコンテンツを対応付けてハッシュに格納
        dates_and_contents = matches.map do |match|
          [DateTime.parse(match[0]), match[1]]
        end
      
        dates_and_contents
      end

end
