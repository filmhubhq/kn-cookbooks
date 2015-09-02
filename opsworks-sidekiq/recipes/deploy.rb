node[:deploy].each do |application, deploy|

  Chef::Log.info("Running Sidekiq deploy for #{application}")

  # Workers are already running on initial deploy, restart should be ignored.
  # Workers should be restarted on future deploys.
  service 'workers' do
    action [:restart]
  end
end
