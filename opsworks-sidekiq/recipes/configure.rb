node[:deploy].each do |application, deploy|

  Chef::Log.info("Setting up Sidekiq workers for #{application}")

  template '/etc/init/workers.conf' do
    source 'workers.conf.erb'
    mode   '0644'
    owner  'root'
    group  'root'
  end

  template '/etc/init/sidekiq.conf' do
    source 'sidekiq.conf.erb'
    mode   '0644'
    owner  'root'
    group  'root'
    variables(
      deploy: deploy,
      env: deploy[:environment_variables]
    )
  end

  service 'workers' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action :enable
  end
end
