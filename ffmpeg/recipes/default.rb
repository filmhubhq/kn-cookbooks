#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright (C) 2015 Kinonation
#

include_recipe 'apt'

apt_repository 'ffmpeg' do
  uri          'ppa:mc3man/trusty-media'
  distribution node['lsb']['codename']
end

package 'ffmpeg'
