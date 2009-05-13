class StatusesController < ApplicationController
  WORDS = %w[%yuiseki% %リナカフェ% %ニコカフェ% %秘密カフェ% %アキバ% %秋葉原% %ねとすた% %ねっとすたー% %UDX% %モス% %ティア%]

  AKIBA = %w[%yuiseki% %ゆいせき% %arduino% %セミナー% %ホコ天% %リナカフェ% %秘密カフェ% %神田% %神輿% %アキバ% %あきば% %秋月% %千石% %マルツ% %おでん缶% %クレバリー% %アキヨド% %秋葉原% %UDX% %LAOX% %ダイビル% %ソフマ% %中央通% %昭和通% %末広町% %岩本町% %万世橋% %三月兎% %電気街%]
  SHIBUYA = %w[%渋谷% %表参道% %原宿% %ハチ公% %センター街%]
  HENTAI = %w[%女装% %男の娘% %hentai% %変態%]
  EVENTS = %w[%ドロリッチ% %セミナー% %arduino% %祭% %焼肉% %イベント% %ティア% %文学フリマ%]
  DORO = %w[%ドロリッチ%]
  USERS = %w[yuiseki akio0911 takano23 ksasao nyatla voqn]

  def ust
    set_time
    set_buzz
    @statuses = Status.find(:all, :limit => 40,
                            :conditions => [ "text LIKE ?", "%http://www.ustream.tv/channel/%" ],
                            :order=>"created_at DESC"
                           )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end

=begin
      URI.extract(status.text).each{|url|
        case url
        when /\s?http:\/\/www\.nicovideo\.jp\/watch\/sm(\w+)\s?$/
          status.text = "<img src='http://b.hatena.ne.jp/entry/image/http://www.nicovideo.jp/watch/sm#{$1}'>
                         <iframe width='300' height='150' src='http://ext.nicovideo.jp/thumb/sm#{$1}' scrolling='no' frameborder='0'></iframe>"
        else
          @statuses.delete(status)
        end
      }
=end
    end
    render :action => "index"
  end


  def nicovideo
    set_time
    @statuses = Status.find(:all, :limit => 200,
                            :conditions => [ "text LIKE ?", "%http://www.nicovideo.jp/watch/%" ],
                            :order=>"created_at DESC" )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
      URI.extract(status.text).each{|url|
        case url
        when /\s?http:\/\/www\.nicovideo\.jp\/watch\/(\w+)\s?$/
          status.text = "<img src='http://b.hatena.ne.jp/entry/image/http://www.nicovideo.jp/watch/#{$1}'>
                         <iframe width='300' height='150' src='http://ext.nicovideo.jp/thumb/#{$1}' scrolling='no' frameborder='0'></iframe>"
        else
          @statuses.delete(status)
        end
      }
    end
  end

  def photo
    set_time
    @statuses = Status.find(:all, :limit => 120,
                            :conditions => [ "text LIKE ? OR text LIKE ?", "%http://f.hatena.ne.jp/twitter/%", "%http://movapic.com/pic/%" ],
                            :order=>"created_at DESC"
                           )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
      URI.extract(status.text).each{|url|
        case url
        when /\s?http:\/\/movapic\.com\/pic\/(\w+?)$/
          t = status.text.dup
          status.text = "<img title='#{t}' src='http://image.movapic.com/pic/m_#{$1}.jpeg' width='120' height='90'>"
        when /\s?http:\/\/f\.hatena\.ne\.jp\/(\w+?)\/(\d*?)$/
          t = status.text.dup
          status.text = "<img title='#{t}'src='http://img.f.hatena.ne.jp/images/fotolife/#{$1[0, 1]}/#{$1}/#{$2[0, 8]}/#{$2}_120.jpg' width='120' height='90' />"
        else
          #status.text.gsub!(url,"<a href='#{url}'>#{url}</a>")
          status.text = "else"
        end
      }
    end
  end

  def events
    set_time
    set_buzz
    @words = EVENTS.dup
    @words.map! {|w| w[1..-2] }
    @statuses = Status.find(:all, :limit => 100, :conditions => [like_cond(EVENTS), EVENTS].flatten!, :order=>"created_at DESC" )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
    end
    render :action => "index"
  end

  def hentai
    set_time
    set_buzz
    @words = HENTAI.dup
    @words.map! {|w| w[1..-2] }
    @statuses = Status.find(:all, :limit => 200, :conditions => [like_cond(HENTAI), HENTAI].flatten!, :order=>"created_at DESC" )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
    end
    render :action => "index"
  end

  def doro
    set_time
    set_buzz
    @words = DORO.dup
    @words.map! {|w| w[1..-2] }
    @statuses = Status.find(:all, :limit => 100, :conditions => [like_cond(DORO), DORO].flatten!, :order=>"created_at DESC" )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
    end
    render :action => "index"
  end

  def shibuya
    set_time
    set_buzz
    @words = SHIBUYA.dup
    @words.map! {|w| w[1..-2] }
    @statuses = Status.find(:all, :limit => 50, :conditions => [like_cond(SHIBUYA), SHIBUYA].flatten!, :order=>"created_at DESC" )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
    end
    render :action => "index"
  end

  def akiba
    set_time
    set_buzz
    @words = AKIBA.dup
    @words.map! {|w| w[1..-2] }
    @statuses = Status.find(:all, :limit => 50, :conditions => [like_cond(AKIBA), AKIBA].flatten!, :order=>"created_at DESC" )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
    end
    render :action => "index"
  end

  def index
    set_time
    set_buzz
    @words = nil

    @cafes = Status.find(:all, :limit => 5, :conditions => [like_cond(AKIBA), AKIBA].flatten!, :order=>"created_at DESC" )
    @statuses = Status.find(
                  :all, :limit => 100,
                  :conditions => ["created_at BETWEEN ? AND ?", @last_visited - 30.seconds , Time.now],
                  :order=>"created_at DESC"
                )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
    end
    render :action => "index"
  end

  def more
    set_time
    set_buzz
    @statuses = Status.find(
                  :all, :limit => 500,
                  :conditions => ["created_at BETWEEN ? AND ?", @last_visited - 30.minutes , Time.now],
                  :order=>"created_at DESC"
                )
    @statuses.each do |status|
      user = Priv.find_by_screen_name(status.screen_name)
      if user
        @statuses.delete(status) if user.flag
      end
    end
    render :action => "index"
  end

  def niconico
    set_time
    set_buzz

    cond = "screen_name = ?"
    0.upto(USERS.size - 2) do |i|
      cond += " OR screen_name = ?"
    end
    @statuses = Status.find(:all, :limit => 40, :conditions => [ cond, USERS ].flatten!, :order=>"created_at DESC")
    render :action => "index"
  end


  private

  def like_cond(word_list)
    cond = "text LIKE ? "
    0.upto(word_list.size - 2) do |i|
      cond += "OR text LIKE ? "
    end
    return cond
  end

  def set_time
    if cookies
      @last_visited = Time.parse(cookies[:time].to_s)
    else
      @last_visited = Time.now - 2.minutes
    end
    cookies[:time] = Time.now.to_s
  end

  def set_buzz
    buzztter = Status.find(:all, :limit => 3, :order=>"created_at DESC", :conditions => ["screen_name = ?", "buzztter"])
    buzz = []
    buzztter.each_with_index do |b, i|
      buzz[i] = b.text.gsub(/^http:\/\/buzztter\.com\/ja\s/, "").split(/\s*,\s*/)
    end
    @buzz = buzz[0] | buzz[1] #| buzz[2]
  end

end
