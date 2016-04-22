#
# Cookbook Name:: sb-ubuntu-desktop
# Recipe:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

run_user = node['user_preferences']['user_name']

user "#{run_user}" do
  shell '/bin/zsh'
  action :modify
end

git "/home/#{run_user}/.oh-my-zsh" do
  repository 'git://github.com/robbyrussell/oh-my-zsh.git'
  action :checkout
end

cookbook_file "/home/#{run_user}/.zshrc" do
  source 'zshrc'
  mode '0644'
end
