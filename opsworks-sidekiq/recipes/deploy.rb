node[:deploy].each do |application, deploy|

  Chef::Log.info("Running Sidekiq deploy for #{application}")

  bash 'restart_sidekiq' do
    code 'echo noop'
    notifies :restart, 'service[sidekiq_workers]'
  end
end
