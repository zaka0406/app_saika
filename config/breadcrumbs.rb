crumb :root do
  link "Home", root_path
end

crumb :about do
  link "プロフィール", about_saikas_path
  parent :root
end

crumb :service do
  link "service", service_saikas_path
  parent :root
end


crumb :contact do
  link "お問い合わせ", new_contact_path
  parent :root
end


crumb :reservation do
  link "ご予約", reservations_path
  parent :root
end

crumb :new_reservation do
  link "新規予約", reservations_path
  parent :reservation
end

crumb :confirm_reservation do
  link "予約確認画面", confirm_reservations_path
  parent :new_reservation
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).