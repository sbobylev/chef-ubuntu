#
# Cookbook Name:: sb-ubuntu-desktop
# Recipe:: unity
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

run_user = node['user_preferences']['user_name']
gtk_theme = node['theme']['gtk_theme']
icon_theme = node['theme']['icon_theme']
menu_in_window_title_bar = node['theme']['show_menu_in_window_title_bar']
input_languages = node['user_preferences']['text_entry_languages']
panel_show_calendar = node['user_preferences']['panel-show-calendar']
panel_show_date = node['user_preferences']['panel-show-date']
panel_show_day = node['user_preferences']['panel-show-day']
panel_show_seconds = node['user_preferences']['panel-show-seconds']
panel_time_format = node['user_preferences']['panel-time-format']
window_placement_mode = node['user_preferences']['window-placement-mode']

# set gtk theme
execute 'set_gtk_theme' do
  user "#{run_user}"
  command "gsettings set org.gnome.desktop.wm.preferences theme #{gtk_theme} && gsettings set org.gnome.desktop.interface gtk-theme #{gtk_theme}"
  action :run
end

# set icon theme
execute 'set_icon_theme' do
  user "#{run_user}"
  command "gsettings set org.gnome.desktop.interface icon-theme #{icon_theme}"
  action :run
end

# set menu behavior
execute 'set_menu_behavior' do
  user "#{run_user}"
  command "gsettings set com.canonical.Unity integrated-menus #{menu_in_window_title_bar}"
  action :run
end

# set text entry languages
execute 'set_input_languages' do
  user "#{run_user}"
  command "gsettings set org.gnome.desktop.input-sources sources \"#{input_languages}\""
  action :run
end

execute 'set_calendar_display_option' do
  user "#{run_user}"
  command "gsettings set com.canonical.indicator.datetime show-calendar #{panel_show_calendar}"
  action :run
end

execute 'set_date_display_option' do
  user "#{run_user}"
  command "gsettings set com.canonical.indicator.datetime show-date #{panel_show_date}"
  action :run
end

execute 'set_day_display_option' do
  user "#{run_user}"
  command "gsettings set com.canonical.indicator.datetime show-day #{panel_show_day}"
  action :run
end

execute 'set_second_display_option' do
  user "#{run_user}"
  command "gsettings set com.canonical.indicator.datetime show-seconds #{panel_show_seconds}"
  action :run
end

execute 'set_time_format_display_option' do
  user "#{run_user}"
  command "gsettings set com.canonical.indicator.datetime time-format #{panel_time_format}"
  action :run
end

execute 'set_window_placement_mode' do
  user "#{run_user}"
  command "dconf write /org/compiz/profiles/unity/plugins/place/mode #{window_placement_mode}"
  action :run
end
