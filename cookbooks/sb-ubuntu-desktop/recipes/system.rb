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
