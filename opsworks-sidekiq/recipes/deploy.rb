node[:deploy].each do |application, deploy|

  Chef::Log.info("Running Sidekiq deploy for #{application}")

  service 'workers' do
    provider Chef::Provider::Service::Upstart
    action :restart
  end
end
