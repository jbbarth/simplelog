class Asset < ActiveRecord::Base

  has_attachment :content_type => :image, 
                  :storage => :file_system, 
                  :max_size => 5.megabytes,
                  :resize_to => '320x200>',
                  :thumbnails => { :thumb => '100x100>' }

  validates_as_attachment

end
