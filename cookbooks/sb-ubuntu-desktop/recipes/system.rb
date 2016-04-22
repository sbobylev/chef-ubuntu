#
# Cookbook Name:: sb-ubuntu-desktop
# Recipe:: system
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# enable trim if / is mounted on ssd
mount '/' do
  fstype   'ext4'
  device   '/dev/mapper/ubuntu--vg-root'
  options  'errors=remount-ro discard noatime'
  action   [:enable]
  only_if 'grep 0 /sys/block/sda/queue/rotational'
end

cron 'fstrim' do
  action :create
  time	:daily
  command 'fstrim -v /'
  only_if 'grep 0 /sys/block/sda/queue/rotational'
end

cookbook_file '/etc/default/grub' do
  source 'grub'
  mode '0544'
  notifies :run, 'execute[update-grub]', :immediately
  only_if 'grep 0 /sys/block/sda/queue/rotational'
end

execute 'update-grub' do
  command 'update-grub'
  action :nothing
end
