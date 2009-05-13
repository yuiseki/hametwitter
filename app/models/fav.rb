require 'hpricot'
require 'feed-normalizer'

class Fav < ActiveRecord::Base

  def self.count_by_user
    options = {
      :group => :screen_name,
      :order => 'count DESC',
      :limit => 50,
      :select => "count(*) AS count, screen_name",
    }

    find :all, options
  end

    def self.get_fav
    1.upto(50) do |i|
      uri = "http://favotter.matope.com/userrss.php?user=yuiseki&mode=fav&page=#{i}"
      feed = FeedNormalizer::FeedNormalizer.parse open(uri)
      favs = []
      feed.entries.each do |e|
        cdata = Hpricot(e.content)
        content = cdata.at("p").inner_html.scan(/#{e.author}<\/a>(.*?)<br \/>/).first
        posted = Time.now
        #save = Status.find_by_id(e.id)
        if content
          fav = { :status_id => e.id, :screen_name => e.author, :text => content.first , :created_at => posted  }
          favs.push fav
          # puts "\n"
        end
      end
      Fav.create(favs)
    end
  end
end
