#        ,--.                 ,--.       ,--.              
#  ,---. `--',--,--,--. ,---. |  | ,---. |  | ,---.  ,---. 
# (  .-' ,--.|        || .-. ||  || .-. :|  || .-. || .-. |
# .-'  `)|  ||  |  |  || '-' '|  |\   --.|  |' '-' '' '-' '
# `----' `--'`--`--`--'|  |-' `--' `----'`--' `---' .`-  / 
#                      `--'                         `---'
#
# SimpleLog - A simple Ruby on Rails weblog application
# Copyright (c) 2006-2007 Garrett Murray
#
# This software is released under the GPL license. See LICENSE file for details.
#
# See README for installation instructions!

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Simplelog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  
    # Make Active Record use UTC-base instead of local time
    config.active_record.default_timezone = :utc
    
    # Use Active Record's schema dumper instead of SQL when creating the test database
    config.active_record.schema_format = :ruby
  end
end

# TODO: remove these global things !!!
# Some storage for application-wide stuff and constants
SL_CONFIG = Hash.new
@@stored_prefs = Hash.new
@@stored_blacklist = Array.new

# SimpleLog version
SL_CONFIG[:VERSION] = '2.0.2'
# Where to check for updates
SL_CONFIG[:UPDATES_URL] = 'simplelog.net/updates/version.xml'
# Where to get the blacklist
SL_CONFIG[:BLACKLIST_URL] = 'simplelog.net/blacklist/current/'
# Used in cookies
SL_CONFIG[:USER_EMAIL_COOKIE] = '_sl_email'
SL_CONFIG[:USER_HASH_COOKIE] = '_sl_hash'
# use space to delimit tags
#TODO: restore: TagList.delimiter = " "
# we load our site's config now
#TODO: see if it's useful: require 'config/server'
# Some required stuff (there are additional requires in the environment sub files)
require 'htmlentities'  # useful string extension
require 'cgi'           # we use this in places
require 'digest/sha1'   # for password hashing
require 'digest/md5'    # for creating MD5 hashes (gravatar)
begin; require 'bluecloth'; rescue LoadError; end   #TODO | should add some flag somewhere
begin; require 'redcloth';  rescue LoadError; end   #TODO | to disable these choices in the
begin; require 'coderay';   rescue LoadError; end   #TODO | admin - so if these aren't loaded
begin; require 'rubypants'; rescue LoadError; end   #TODO | then they can't be selected

#old things in config/server.rb
# Are you using Dreamhost?
SL_CONFIG[:DREAMHOST]     = 'no'  # (yes or no) are you deploying this app on a DH server? (see DH_README for details)
# Database type
SL_CONFIG[:DB_TYPE_MYSQL] = 'no' # (yes or no) are you using mysql as the database type?

# Set your mail configuration for comment notification (optional)
#ActionMailer::Base.smtp_settings = {
#  :address        => '',
#  :port           => 25, 
#  :domain         => '',
#  :user_name      => '',
#  :password       => '',
#  :authentication => :login
#}
