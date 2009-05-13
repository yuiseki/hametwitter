# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def filter(text)
    text = h(text)
    URI.extract(text).each{|url|
      case url
      when /.jpg$|.png$/
        text.gsub!(url,"<img src='#{url}' width='100' height='100' />")
      when /^http:\/\/www\.nicovideo\.jp\/watch\/sm(\w+)$/
        text.gsub!(url,"nicovideo<a href='#{url}'><img src='http://tn-skr3.smilevideo.jp/smile?i=#{$1}' width='65' height='50' /></a>")
      when /^http:\/\/movapic\.com\/pic\/(\w+)$/
        text.gsub!(url,"movapic::<img src='http://image.movapic.com/pic/m_#{$1}.jpeg' width='65' height='65'>")
      when /^http:\/\/f\.hatena\.ne\.jp\/(\w+?)\/(\d*?)$/
        text.gsub!(url,"hatena::<img src='http://img.f.hatena.ne.jp/images/fotolife/#{$1[0, 1]}/#{$1}/#{$2[0, 8]}/#{$2}_120.jpg' width='100' height='100' />")
      else
        text.gsub!(url,"<a href='#{url}'>#{url}</a>")
      end
    }

    words=["インフル", "パンデミック", "豚", "トン",
           "GW",
           "萌",
           "ニュース",
           "コミティア",
           "秘密",
           "カフェ",
           "niconicocafe",
           "ニコ",
           "サンボ",
           "うんこ",
           "ウンコ",
           "クソ",
           "モス",
           "Mac",
           "マック",
           "糞",
           "unko",
           "糞便",
           "破滅",
           "つぶやき",
           "ねとすた",
           "ネットスター",

           "アニメ", "東のエデン", "けいおん",
           "ネット", "ストーキング",
           "ユビキタス",
           "ニート", "金", "肉",
           "ゆいせき",
           "チームラボ", "Cerevo", "セレボ",

           "オフ",
           "なう", "ナウ",
           "日本", "アメリカ",
           "リナ", "アキバ", "秋葉原", "アキヨド",
           "末広町",
           "UDX",
           "渋谷",
           "プログラミング",
           "Ruby",
           "Rails",
    ]
    words = words | @buzz if @buzz
    words = words | @words if @words
    words.each do |word|
      text.gsub!(/#{Regexp.escape(word)}/, "<span style='color:red; font-size:1.5em; font-weight:bold;'>#{word}</span>")
    end

    text.scan(/^@(\w*?)\s/).each do |at|
      text.gsub!(at[0], image_tag(
        "http://usericons.relucks.org/twitter/#{at}",
        :size => "20x20") + at[0]
      )
    end
    text.scan(/(ドロリッチ)/).each do |at|
      text.gsub!(at[0], image_tag(
        "http://storage.kanshin.com/free/img_40/401296/k1229123509.jpg",
        :size => "80x80")
      )
    end
    text
  end
end
