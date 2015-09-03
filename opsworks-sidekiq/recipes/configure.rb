node[:deploy].each do |application, deploy|

  Chef::Log.info("Setting up Sidekiq workers for #{application}")

  config = deploy[:sidekiq] if !deploy[:sidekiq].nil?
  number_of_workers = config[:number_of_workers] || 1

  template '/etc/init/sidekiq_workers.conf' do
    source 'sidekiq_workers.conf.erb'
    mode   '0644'
    owner  'root'
    group  'root'
    variables(
      number_of_workers: number_of_workers
    )
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

  service 'sidekiq_workers' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action :enable
  end
end
