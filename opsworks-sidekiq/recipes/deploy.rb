node[:deploy].each do |application, deploy|

  Chef::Log.info("Running Sidekiq deploy for #{application}")

  # Include the configure recipe so the service will be accessible.
  include_recipe 'opsworks-sidekiq::configure'

  bash 'restart_sidekiq' do
    code 'echo noop'
    notifies :restart, 'service[sidekiq_workers]'
  end
end
