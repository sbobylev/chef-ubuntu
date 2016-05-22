#
# Cookbook Name:: sb-ubuntu-desktop
# Recipe:: packages
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

user_name = node['user_preferences']['user_name']

# Add noobslab icon repo
apt_repository 'noobslab-ubuntu-icons' do
  uri 'http://ppa.launchpad.net/noobslab/icons/ubuntu'
  components ['main']
  distribution node['lsb']['codename']
  trusted true
end

# Add noobslab theme repo
apt_repository 'noobslab-ubuntu-themes' do
  uri 'http://ppa.launchpad.net/noobslab/themes/ubuntu'
  components ['main']
  distribution node['lsb']['codename']
  trusted true
end

# Install vim
package 'vim'

# Install Git
package 'git'

# Install Docker
package 'docker.io'

# Add current user to the docker group
group 'docker' do
  action :modify
  members "#{user_name}"
  append true
end

# Install docker compose
package 'docker-compose'

# Install VirtualBox
package 'virtualbox'

# Add current user to the vboxusers group
group 'vboxusers' do
  action :modify
  members "#{user_name}"
  append true
end

# Install Vagrant
package 'vagrant'

# Install zsh
package 'zsh'

# Install pip
package 'python-pip'

# Install Terminus font
package 'xfonts-terminus'

# Install Faenza icon theme
package 'faenza-icon-theme'

# Install Numix GTK theme
package 'numix-gtk-theme'

# Install parcellite
package 'parcellite'

# Install Chrome and its dependencies
['libappindicator1', 'libindicator7'].each do |pkg|
  package pkg
end

# Get the latest version of Google Chrome
remote_file "#{Chef::Config[:file_cache_path]}/google-chrome-stable_current_amd64.deb" do
  source 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
  action :create
  not_if 'dpkg -l google-chrome-stable'
end

# Install Chrome deb package 
dpkg_package "google-chrome" do
  source "#{Chef::Config[:file_cache_path]}/google-chrome-stable_current_amd64.deb"
  action :install
  not_if 'dpkg -l google-chrome-stable'
end

# Install TLP for power management
['tlp', 'tlp-rdw'].each do |pkg|
  package pkg do
     action :install
     only_if {::File.directory?("/sys/class/power_supply") }
  end
end

# Install Russian localization
['hunspell-ru', 'mythes-ru', 'mueller7-dict', 'firefox-locale-ru', 'language-pack-ru', 'language-pack-gnome-ru'].each do |pkg|
  package pkg
end

python_pip "awscli"
