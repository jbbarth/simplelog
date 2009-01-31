class Image < ActiveRecord::Base

  has_attachment :content_type => :image, 
                  :storage => :file_system, 
                  :max_size => 5.megabytes,
                  :resize_to => '740x400>',
                  :thumbnails => { :thumb => '100x100>' },
                  :path_prefix => 'public/assets'

  validates_as_attachment

end
