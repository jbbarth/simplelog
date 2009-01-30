class Asset < ActiveRecord::Base
  def self.save(upload)
    directory = "public/files"
    path = File.join(directory, upload['file'].original_filename)
    File.open(path, "wb") { |f| f.write(upload['file'].read) }
  end
end
