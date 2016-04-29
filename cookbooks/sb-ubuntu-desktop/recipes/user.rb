#
# Cookbook Name:: sb-ubuntu-desktop
# Recipe:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

run_user = node['user_preferences']['user_name']

# modify defaul shell
user "#{run_user}" do
  shell '/bin/zsh'
  action :modify
end

# install oh my zsh
git "/home/#{run_user}/.oh-my-zsh" do
  repository 'git://github.com/robbyrussell/oh-my-zsh.git'
  action :checkout
end

# create zshrc
cookbook_file "/home/#{run_user}/.zshrc" do
  source 'zshrc'
  mode '0644'
end

# Configure vim
cookbook_file "/home/#{user_name}/.vimrc" do
  source 'vimrc'
  owner "#{user_name}"
  group "#{user_name}"
  mode '0755'
  action :create
end

# Create vim swap file directory
directory "/home/#{user_name}/.vim/swapfiles/" do
  action :create
  recursive true
  owner "#{user_name}"
  group "#{user_name}"
end
