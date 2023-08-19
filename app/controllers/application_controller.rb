class ApplicationController < ActionController::Base
    before_action :check_admin_login, if: :devise_controller?

    private
  
    def check_admin_login
      return unless params[:user]&.dig(:admin_id) == 'your_admin_id' &&
                    params[:user]&.dig(:admin_password) == 'your_admin_password'
  
      sign_in(User.new, scope: :user)
      redirect_to admin_dashboard_path # 管理者画面へのパスを設定してください
    end

end
