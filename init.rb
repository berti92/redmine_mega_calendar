require 'filters.rb'
require 'vpim'

Redmine::Plugin.register :mega_calendar do
  name 'Mega Calendar plugin'
  author 'Dmitry Kuznetsov'
  description 'Better calendar for redmine'
  version '1.7.4'
  url 'https://github.com/ddk85/mega_calendar'
  author_url 'https://github.com/ddk85'
  requires_redmine :version_or_higher => '3.0.1'
  #menu(:top_menu, :calendar, { :controller => 'calendar', :action => 'index' }, :caption => :calendar, :if => Proc.new {(!Setting.plugin_mega_calendar['allowed_users'].blank? && Setting.plugin_mega_calendar['allowed_users'].include?(User.current.id.to_s) ? true : false)})
  #menu(:top_menu, :calendar, { :controller => 'calendar', :action => 'index' }, :caption => :calendar, :if => Proc.new {(!Setting.plugin_mega_calendar['displayed_within_calendar'].blank? && Setting.plugin_mega_calendar['displayed_within_calendar'].include?(User.current.id.to_s) ? true : false)})
  menu(:top_menu, :calendar, { :controller => 'calendar', :action => 'index' }, :caption => :calendar, :if => Proc.new {(!Setting.plugin_mega_calendar['allowed_users'].blank? && Setting.plugin_mega_calendar['allowed_users'].include?(User.current.id.to_s) ? true : false)})
  #menu(:top_menu, :holidays, { :controller => 'holidays', :action => 'index' }, :caption => :holidays, :if => Proc.new {(!Setting.plugin_mega_calendar['allowed_users_edit'].blank? && Setting.plugin_mega_calendar['allowed_users_edit'].include?(User.current.id.to_s) ? true : false)})
  menu(:top_menu, :holidays, { :controller => 'holidays', :action => 'index' }, :caption => :holidays, :if => Proc.new {(!Setting.plugin_mega_calendar['allowed_users_edit'].blank? && Setting.plugin_mega_calendar['allowed_users_edit'].include?(User.current.id.to_s) ? true : false)})
  settings :default => {'display_empty_dates' => 0, 'displayed_type' => 'users', 'displayed_users' => User.where(["users.login IS NOT NULL AND users.login <> '' AND users.status = 1"]).collect {|x| x.id.to_s}, 'default_holiday_color' => 'D59235', 'default_illday_color' => 'E383F2', 'default_buitrip_color' => 'FF9830', 'default_remote_work_color' => 'FF9830', 'default_meeting_color' => 'FF9830', 'default_timeoff_color' => 'FF9830', 'default_event_color' => '4F90FF', 'sub_path' => '/', 'week_start' => '1', 'allowed_users' => User.where(["users.login IS NOT NULL AND users.login <> '' AND users.status = 1"]).collect {|x| x.id.to_s}, 'allowed_users_edit' => User.where(["users.login IS NOT NULL AND users.login <> '' AND users.status = 1"]).collect {|x| x.id.to_s}}, :partial => 'settings/mega_calendar_settings'
end

Rails.configuration.to_prepare do
  require_dependency File.join( File.dirname(File.realpath(__FILE__)), 'lib', 'users_controller_patch' )
  require_dependency File.join( File.dirname(File.realpath(__FILE__)), 'lib', 'issues_controller_patch' )
end
