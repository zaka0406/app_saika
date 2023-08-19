RailsAdmin.config do |config|
  config.authenticate_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'saika0312@gmail.com' && password == 'harusora0312'
    end
  end

  config.asset_source = :webpacker
  config.main_app_name = ['Reservation', 'Admin']
  
  # 管理者用ビューのパスを設定
  config.navigation_static_label = "Calendar"
  config.navigation_static_links = { "Calendar" => " /saikas/admin" }

  
# シンプルカレンダーの管理者用ビューパス
  

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  
  end
  
  # ダッシュボードの非表示カラムの設定
  config.model Reservation do
    list do
      exclude_fields :start_time,:created_at, :updated_at
    end
  end
  
  config.model Saika do
      list do
        exclude_fields :start_time,:created_at, :updated_at
      end
  end

## == Devise ==
config.authenticate_with do
  warden.authenticate! scope: :user
end
config.current_user_method(&:current_user)

 ## == Cancan ==
#  config.authorize_with :cancan
  
end
