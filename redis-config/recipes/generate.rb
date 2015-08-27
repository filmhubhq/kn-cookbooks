# Based on:
# https://aws.amazon.com/blogs/aws/using-aws-elasticache-for-redis-
# with-aws-opsworks/
node[:deploy].each do |application, deploy|
  approot = "#{deploy[:deploy_to]}/current"

  # Use template redis.yml.erb to generate 'config/redis.yml'
  template "#{approot}/config/redis.yml" do
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
