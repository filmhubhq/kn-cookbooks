node[:deploy].each do |application, deploy|

  Chef::Log.info("Configuring Sidekiq for application #{application}")

  template '/etc/init/sidekiq.conf' do
    source 'sidekiq.conf.erb'
    mode   '0644'
    owner  'root'
    group  'root'

    variables(
      user: deploy[:user],
      group: deploy[:group],
      app_root: "#{deploy[:deploy_to]}/current",
      environment: OpsWorks::Escape.escape_double_quotes(deploy[:environment_variables])
    )
  end
end
