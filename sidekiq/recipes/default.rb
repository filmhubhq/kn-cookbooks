node[:deploy].each do |application, deploy|
  app_root = "#{deploy[:deploy_to]}/current"

  template '/etc/init/sidekiq.conf' do
    source 'sidekiq.conf.erb'
    mode   '0644'
    owner  'root'
    group  'root'

    variables(
      user: deploy[:user],
      group: deploy[:group],
      app_root: app_root
    )
  end

  service 'sidekiq' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
  end

  bash 'restart_sidekiq' do
    code 'echo noop'
    notifies :restart, 'service[sidekiq]'
  end
end
