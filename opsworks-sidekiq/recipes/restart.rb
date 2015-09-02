node[:deploy].each do |application, deploy|

  Chef::Log.info("Restarting Sidekiq for application #{application}")

  service 'sidekiq' do
    action [:stop, :start]
    provider Chef::Provider::Service::Upstart
  end
end
