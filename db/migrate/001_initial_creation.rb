# $Id: 001_initial_creation.rb 198 2006-08-01 20:52:15Z garrett $

#
# initial creation sets up the simplelog db and creates a few sample
# objects like a sample post, tag and the temporary author you use
# to log in to the admin section
#

require 'server.rb'

class InitialCreation < ActiveRecord::Migration
  def self.up
    # we'll use this a few times
    time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    
    # the posts table
    create_table "posts", :options => (SL_CONFIG[:DB_TYPE_MYSQL] == 'yes' ? 'ENGINE=MyISAM' : '') do |t|
      t.column "author_id", :integer, :null => false, :default => 0
      t.column "created_at", :datetime, :null => false
      t.column "modified_at", :datetime, :null => false
      t.column "permalink", :string, :limit => 128
      t.column "title", :string, :limit => 255
      t.column "synd_title", :string, :limit => 255
      t.column "summary", :text
      t.column "body_raw", :text
      t.column "extended_raw", :text
      t.column "body", :text
      t.column "extended", :text
      t.column "is_active", :boolean, :default => true
    end
    
    # create an example first post (via SQL because our prefs aren't
    # loaded yet and we don't know which filter to use!)
    temp_body = 'Welcome to <a href="http://simplelog.net" title="SimpleLog">SimpleLog</a>! This is an example first post'
    execute "INSERT INTO posts (author_id, created_at, modified_at, permalink, title, synd_title, summary, body_raw, body, extended_raw, extended) VALUES (1, '#{time}', '#{time}', 'welcome_to_simplelog_this_is', 'My First Post', 'Welcome to Simplelog! This is...', 'This is the first post of my weblog.', '#{temp_body}', '<p>#{temp_body}</p>', '', '')"
    
    if SL_CONFIG[:DB_TYPE_MYSQL] == 'yes'
      # add a fulltext index if we're using mysql
      execute "ALTER TABLE posts ADD FULLTEXT searchable (title, body, extended)"
    end
    
    # tags table
    #create_table "tags", :options => (SL_CONFIG[:DB_TYPE_MYSQL] == 'yes' ? 'ENGINE=MyISAM' : '') do |t|
    #  t.column "name", :string, :limit => 128
    #end
    
    # tags/posts join table (HABTM)
    #create_table "tags_posts", :id => false, :options => (SL_CONFIG[:DB_TYPE_MYSQL] == 'yes' ? 'ENGINE=MyISAM' : '') do |t|
    #  t.column "tag_id", :integer
    #  t.column "post_id", :integer
    #end
    
    # tag the first post with a sample tag
    #post = Post.find(:first)
    #post.tag "sample"
    #post.tag "simplelog"
    
    # authors table (for admin section)
    create_table "authors", :options => (SL_CONFIG[:DB_TYPE_MYSQL] == 'yes' ? 'ENGINE=MyISAM' : '') do |t|
      t.column "created_at", :datetime, :null => false
      t.column "modified_at", :datetime, :null => false
      t.column "email", :string, :limit => 255
      t.column "hashed_pass", :string, :limit => 40
      t.column "name", :string, :limit => 100
      t.column "url", :string, :limit => 255
      t.column "is_active", :boolean, :default => false
    end
    
    # create a temporary first author to that we can log in to the admin section
    # username: temp@email.com, password: !@gonow
    execute "INSERT INTO authors (created_at, modified_at, email, hashed_pass, name, url) VALUES ('#{time}', '#{time}', 'temp@email.com', '#{Author.do_password_hash('!@gonow')}', 'Temporary User', 'http://simplelog.net')"
    a = Author.find(:first)
    a.is_active = true
    a.save
    
    # create sessions table for session store (much faster!), see enabled option in env
    create_table "sessions", :options => (SL_CONFIG[:DB_TYPE_MYSQL] == 'yes' ? 'ENGINE=MyISAM' : '') do |t|
      t.column "session_id", :string, :limit => 255
      t.column "data", :text
      t.column "updated_at", :datetime
    end
  end

  def self.down
    # just drop all the tables
    drop_table "posts"
    #drop_table "tags"
    #drop_table "tags_posts"
    drop_table "authors"
    drop_table "sessions"
  end
end
