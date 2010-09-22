Simplelog::Application.routes.draw do |map|
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
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
  map.connect 'tags', :controller => 'post', :action => 'tags_list'
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
  # authors tags comments page post
  %w(author tag comment page post).each do |i|
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
