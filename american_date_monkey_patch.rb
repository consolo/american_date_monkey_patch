require 'date'
gem 'activerecord'

##
# &copy; 2009 Andrew Coleman
# Released under MIT license.
# http://www.opensource.org/licenses/mit-license.php
#
# total hack to allow american style date parsing.
# does not allow european-ish date parsing, sorry.
#
# some credit from:
# http://talklikeaduck.denhaven2.com/2009/04/26/ruby-1-9-compatibility-for-ri_cal-what-it-took-and-some-side-thoughts
#
module AmericanDateMonkeyPatch
  def to_date
    if self.blank?
      nil
    elsif self =~ /(\d{1,2})\/(\d{1,2})\/(\d{4})/
      ::Date.civil($3.to_i, $1.to_i, $2.to_i) rescue nil
    else
      ::Date.new(*::Date._parse(self, false).values_at(:year, :mon, :mday)) rescue nil
    end
  end
  
  def to_time
    if self.blank?
      nil
    elsif self =~ /(\d{1,2})\/(\d{1,2})\/(\d{4}) (\d{1,2}):?(\d{2})/
      year = $3.to_i
      month = $1.to_i
      day = $2.to_i
      hour = $4.to_i
      minute = $5.to_i
      hour += 12 if self =~ /PM\s*$/
      ::DateTime.civil(year, month, day, hour, minute) rescue nil
    else
      super
    end
  end
end

# Only for Ruby 1.9. Older versions seem to work just fine.
if RUBY_VERSION.to_f >= 1.9
  String.send :include, AmericanDateMonkeyPatch
  # active record will call something else on dates on access
  class ActiveRecord::ConnectionAdapters::Column
    def self.fallback_string_to_date(string)
      string.to_date
    end
  end
end

