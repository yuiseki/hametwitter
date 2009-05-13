gem 'mechanize', '= 0.7.8'
require 'mechanize'

class Priv < ActiveRecord::Base
  USER = ""
  PASS = ""

def self.crawler
    agent = WWW::Mechanize.new
    agent.user_agent_alias = 'Windows IE 6'
    page = agent.get('http://twitter.com/login')
    page.body = page.body.toutf8

    form = page.forms[1]
    form['session[username_or_email]'] = USER
    form['session[password]'] = PASS
    page = agent.submit(form, form.buttons.first)

  for i in 1..231
    puts i
    puts "\n"
    page = agent.get('http://twitter.com/friends?page=' + i.to_s)
    page.body = page.body.toutf8

      #ページ内のUserに対して繰り返し
      page.search('tr.person').each do |person|
        username = person.search('a.uid').first.get_attribute(:href)
        username = username.gsub(%r{http://twitter.com/.*?}m,'\1')


        if person.search('img.lock').first
          pri = true
        else
          pri = false
        end
        #登録済みかチェックして、いなかった場合だけ追加
        check = self.find_by_screen_name(username)
        users = self.create( [{ :screen_name => username, :flag => pri },] ) if not check
        puts username if pri
      end
  end
end

end
