node[:deploy].each do |application, deploy|

  Chef::Log.info("Starting Sidekiq workers for #{application}")

  service 'workers' do
    action [:restart]
  end
end
