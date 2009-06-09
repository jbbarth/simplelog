# $Id: routes.rb 300 2007-02-01 23:01:00Z garrett $

#--
# Copyright (C) 2006-2007 Garrett Murray
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with this program (doc/LICENSE); if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301 USA.
#++

ActionController::Routing::Routes.draw do |map|
  
  tokens = /archives|older|past/

  #????
  #map.resources :posts, :has_many => :comments

  # site ########################################################################################
  # index page
  map.connect '', :controller => 'post', :action => 'list'
  # archives list
  map.connect ':archive_token', :controller => 'post', :action => 'archives_list',
                :archive_token => tokens
  # archives tags list (there's another route for this below as well)
  map.connect ':archive_token/tags', :controller => 'post', :action => 'tags_list',
                :archive_token => tokens
  # archives by tag
  map.connect ':archive_token/tags/:tag', :controller => 'post', :action => 'tagged',
                :archive_token => tokens
  # archives by author
  map.connect ':archive_token/authors/:id', :controller => 'post', :action => 'by_author',
                :archive_token => tokens
  # individual archives
  map.connect ':archive_token/:year/:month/:day/:link', :controller => 'post', :action => 'show',
                :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/,
                :archive_token => tokens
  # archives by day
  map.connect ':archive_token/:year/:month/:day', :controller => 'post', :action => 'by_day',
                :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/,
                :archive_token => tokens
  # archives by month
  map.connect ':archive_token/:year/:month', :controller => 'post', :action => 'by_month',
                :year => /\d{4}/, :month => /\d{1,2}/,
                :archive_token => tokens
  # archives by year
  map.connect ':archive_token/:year', :controller => 'post', :action => 'by_year',
                :year => /\d{4}/,
                :archive_token => tokens
  # tags list
  map.connect 'tags', :controller => 'post', :action => 'list'
  # comments
  map.connect 'comments/add', :controller => 'post', :action => 'add_comment'
  # search
  map.connect 'search', :controller => 'post', :action => 'search'
  map.connect 'search/full', :controller => 'post', :action => 'search_full'
  # rss feeds
  map.connect 'rss', :controller => 'post', :action => 'feed_all_rss'
  map.connect 'comments/rss', :controller => 'post', :action => 'feed_comments_rss'
  # "static" pages
  map.connect 'pages/:link', :controller => 'page', :action => 'show'

  # admin section ###############################################################################
  # a bit more specific than rails usually uses (i.e. just using :controller/:model/etc) because
  # we've placed everything in one controller. therefore, we have to write everything out here.
  # login/out
  map.connect 'login/do', :controller => 'author', :action => 'do_login'
  map.connect 'login', :controller => 'author', :action => 'login'
  map.connect 'logout', :controller => 'author', :action => 'logout'
  # index
  map.connect 'admin', :controller => 'admin/base', :action => 'index'
  # blacklist (for comments)
  map.connect 'admin/blacklist', :controller => 'admin/blacklist', :action => 'blacklist_list'
  map.connect 'admin/blacklist/update', :controller => 'admin/blacklist', :action => 'blacklist_update'
  map.connect 'admin/blacklist/remote/add/:item', :controller => 'admin/blacklist', :action => 'blacklist_add_remote'
  map.connect 'admin/blacklist/remote/destroy/:item', :controller => 'admin/blacklist', :action => 'blacklist_destroy_remote'
  map.connect 'admin/blacklist/get/rules', :controller => 'admin/blacklist', :action => 'blacklist_get_remote'
  # comments page post
  %w(comment page post).each do |i|
    map.connect "admin/#{i}s", :controller => "admin/#{i}s", :action => "#{i}_list"
    map.connect "admin/#{i}s/show/:id", :controller => "admin/#{i}s", :action => "#{i}_show"
    map.connect "admin/#{i}s/edit/:id", :controller => "admin/#{i}s", :action => "#{i}_edit"
    map.connect "admin/#{i}s/new", :controller => "admin/#{i}s", :action => "#{i}_new"
    map.connect "admin/#{i}s/create", :controller => "admin/#{i}s", :action => "#{i}_create"
    map.connect "admin/#{i}s/update/:id", :controller => "admin/#{i}s", :action => "#{i}_update"
    map.connect "admin/#{i}s/destroy/:id", :controller => "admin/#{i}s", :action => "#{i}_destroy"
    map.connect "admin/#{i}s/search", :controller => "admin/#{i}s", :action => "#{i}_search"
    map.connect "admin/#{i}s/preview", :controller => "admin/#{i}s", :action => "#{i}_preview"
  end
  # [NEW!] restful urls : authors
  %w(author tag).each do |i|
    map.connect "admin/#{i}s", :controller => "admin/#{i}s", :action => "list"
    map.connect "admin/#{i}s/show/:id", :controller => "admin/#{i}s", :action => "show"
    map.connect "admin/#{i}s/edit/:id", :controller => "admin/#{i}s", :action => "edit"
    map.connect "admin/#{i}s/new", :controller => "admin/#{i}s", :action => "new"
    map.connect "admin/#{i}s/create", :controller => "admin/#{i}s", :action => "create"
    map.connect "admin/#{i}s/update/:id", :controller => "admin/#{i}s", :action => "update"
    map.connect "admin/#{i}s/destroy/:id", :controller => "admin/#{i}s", :action => "destroy"
    map.connect "admin/#{i}s/search", :controller => "admin/#{i}s", :action => "search"
    map.connect "admin/#{i}s/preview", :controller => "admin/#{i}s", :action => "preview"
  end
  # comments
  map.connect 'admin/comments/approve/:id/toggle', :controller => 'admin/comments', :action => 'comment_approval'
  map.connect 'admin/comments/bypost/:id', :controller => 'admin/comments', :action => 'comments_by_post'
  map.connect 'admin/comments/toggle', :controller => 'admin/comments', :action => 'comments_toggle'
  map.connect 'admin/comments/approve/all', :controller => 'admin/comments', :action => 'comments_approve_all'
  map.connect 'admin/comments/delete/unapproved', :controller => 'admin/comments', :action => 'comments_delete_unapproved'
  # pages
  map.connect 'admin/pages/permalink', :controller => 'admin/pages', :action => 'page_permalink'
  # posts
  map.connect 'admin/posts/batch/comments', :controller => 'admin/posts', :action => 'post_batch_comments'
  # images
  map.connect 'admin/images/:action/:id', :controller => 'admin/images'
  map.connect 'admin/images/:action', :controller => 'admin/images'
  map.connect 'admin/images', :controller => 'admin/images', :action => 'index'
  # prefs
  map.connect 'admin/prefs', :controller => 'admin/prefs', :action => 'prefs_list'
  map.connect 'admin/prefs/save', :controller => 'admin/prefs', :action => 'prefs_save'
  map.connect 'admin/prefs/cache/clear', :controller => 'admin/prefs', :action => 'prefs_clear_cache'
  # ping
  map.connect 'admin/ping/do', :controller => 'admin/misc', :action => 'do_ping'
  # help
  map.connect 'admin/help', :controller => 'admin/misc', :action => 'help'
  # check for updates
  map.connect 'admin/updates', :controller => 'admin/misc', :action => 'updates'
  map.connect 'admin/updates/do', :controller => 'admin/misc', :action => 'do_update_check'
  map.connect 'admin/updates/auto/toggle', :controller => 'admin/misc', :action => 'toggle_updates_check'
  # xmlrpc
  map.connect 'xmlrpc/api', :controller => 'xmlrpc', :action => 'api'
  # sorting
  map.connect ':controller/:action/:id/:sort/:order'
  map.connect ':controller/:action/:sort/:order'
  # some defaults to move stuff around for 404s #################################################
  map.connect 'notfound', :controller => 'application', :action => 'handle_unknown_request'
  map.connect '*anything', :controller => 'application', :action => 'handle_unknown_request'
  # default route (not really used here...)
  map.connect ':controller/:action/:id'
  
end
