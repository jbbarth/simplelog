# $Id: 018_default_blacklist_items.rb 296 2007-01-30 22:31:51Z garrett $

#
# migration for 1.3 adding default blacklist items
#

class DefaultBlacklistItems < ActiveRecord::Migration
  def self.up
    
    default_list = '([\w\-_.]+\.)?(l(so|os)tr)\.[a-z]{2,}
(blow)[\w\-_.]*job[\w\-_.]*\.[a-z]{2,}
(buy)[\w\-_.]*online[\w\-_.]*\.[a-z]{2,}
(diet|penis)[\w\-_.]*(pills|enlargement)[\w\-_.]*\.[a-z]{2,}
(i|la)-sonneries?[\w\-_.]*\.[a-z]{2,}
(levitra|lolita|phentermine|viagra|vig-?rx|zyban|valtex|xenical|adipex|meridia\b)[\w\-_.]*\.[a-z]{2,}
(magazine)[\w\-_.]*(finder|netfirms)[\w\-_.]*\.[a-z]{2,}
(mike)[\w\-_.]*apartment[\w\-_.]*\.[a-z]{2,}
(milf)[\w\-_.]*(hunter|moms|fucking)[\w\-_.]*\.[a-z]{2,}
(online)[\w\-_.]*casino[\w\-_.]*\.[a-z]{2,}
(prozac|zoloft|xanax|valium|hydrocodone|vicodin|paxil|vioxx)[\w\-_.]*\.[a-z]{2,}
(ragazze)-?\w+\.[a-z]{2,}
(ultram\b|\btenuate|tramadol|pheromones|phendimetrazine|ionamin|ortho.?tricyclen|retin.?a)[\w\-_.]*\.[a-z]{2,}
(valtrex|zyrtec|\bhgh\b|ambien\b|flonase|allegra|didrex|renova\b|bontril|nexium)[\w\-_.]*\.[a-z]{2,}
-4-you.info
-4u.info
-mobile-phones.org
-site.info'

    # split the list
    items = default_list.split(/\n/).map(&:strip).delete_if{|i| i == ''}
    items.map!{|i| {:item => i} }
    Blacklist.create(items)
    
  end

  def self.down
    Blacklist.delete_all
  end
end
