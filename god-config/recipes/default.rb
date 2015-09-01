node[:deploy].each do |application, deploy|
  god_monitor "sidekiq",
    :max_memory => 350,
    :app_root => "#{deploy[:deploy_to]}/current",
    :env => deploy[:environment],
    :uid => deploy[:user],
    :gid => deploy[:group] do
      config "sidekiq.god.erb"
  end
end
