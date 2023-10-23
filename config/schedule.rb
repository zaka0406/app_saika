# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.


# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# Set the environment to production
set :environment, 'production'

# Set the output log file for your cron jobs
set :output, '/path/to/log/cron_log.log'
set :job_template, "/usr/bin/ruby -S :task :output"
# Schedule the Rake task to run every day at 12:00 AM
every 1.day, at: '12:00 am' do
  rake "update_blogs:fetch"
end