# Based on:
# http://docs.aws.amazon.com/opsworks/latest/userguide/other-services-redis.html
node[:deploy].each do |application, deploy|
  app_root = "#{deploy[:deploy_to]}/current"

  # Use template redis.yml.erb to generate 'config/redis.yml'
  template "#{app_root}/config/redis.yml" do
    source "redis.yml.erb"

    mode "0660"
    owner deploy[:user]
    group deploy[:group]

    # Define variable @redis to be used in the template
    variables(:redis => deploy[:redis] || {})

    # Only generate a file if there is Redis configuration
    not_if { deploy[:redis].blank? }
  end
end
