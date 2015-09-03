node[:deploy].each do |application, deploy|

  Chef::Log.info("Running Sidekiq deploy for #{application}")

  service 'workers' do
    action :restart
  end
end
