node[:deploy].each do |application, deploy|
  god_monitor "resque",
    :max_memory => 350,
    :app_root => "#{deploy[:deploy_to]}/current",
    :env => deploy[:environment],
    :uid => deploy[:user],
    :gid => deploy[:group] do
      config "resque.god.erb"
  end
end
