# $Id: theme.rb 192 2006-08-01 18:31:10Z garrett $

class Theme
  cattr_accessor :cache_theme_lookup
  @@cache_theme_lookup = false

  attr_accessor :name, :path, :description_html

  def initialize(name, path=nil)
    @name = name
    @path = path ||= Theme.path_to_theme(name)
  end
 
  def description
    File.read("#{path}/about.markdown") rescue "### #{name}"
  end
  
  def written_by
    text = File.read("#{path}/author.markdown") rescue ""
    splitted = text.split("\n")
    return (splitted.length > 1 ? splitted[0] : text)
  end
  
  def self.themes_root
    RAILS_ROOT + "/themes"
  end
  
  def self.path_to_theme(theme)
    "#{themes_root}/#{theme}"
  end
  
  def self.theme_from_path(path)
    name = path.scan(/[- \w]+$/i).flatten.first
    self.new(name, path)
  end

  def self.find_all
    installed_themes.inject([]) do |array, path|
      array << theme_from_path(path)
    end
  end

  def self.installed_themes
    cache_theme_lookup ? @theme_cache ||= search_theme_directory : search_theme_directory
  end  

  def self.search_theme_directory
    Dir.glob("#{themes_root}/[-_a-zA-Z0-9 ]*").collect do |file|
      file if File.directory?(file)      
    end.compact
  end  
end
