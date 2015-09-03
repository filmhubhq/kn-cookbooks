node[:deploy].each do |application, deploy|

  Chef::Log.info("Running Sidekiq deploy for #{application}")

  # The restart action starts the service if it is stopped or
  # restarts it if it is already running.
  service 'sidekiq_workers' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action :restart
  end
end
