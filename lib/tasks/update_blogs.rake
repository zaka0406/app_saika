namespace :update_blogs do
    desc "Update blogs from RSS feed"
    task fetch: :environment do
      require 'httparty'
      require 'nokogiri'
  
      # RSSフィードのURLを指定
      feed_url = "http://rssblog.ameba.jp/chi-harusora/rss20.xml"
  
      # フィードを取得
      response = HTTParty.get(feed_url)
  
      if response.code == 200
        doc = Nokogiri::XML(response.body)
  
        doc.xpath('//item').each do |item|
          title = item.at('title').text
          content = item.at('description').text
          published_at = item.at('pubDate').text
          theme = item.at('category')&.text || 'デフォルトのテーマ'
           # URLを抽出
          url = item.at('link').text
          url ||= "デフォルトのURL"
          
          Blog.create(
            title: title,
            content: content,
            published_at: DateTime.parse(published_at),
            theme: theme,
            url: url
          )
        end
      end
    end
  end
  