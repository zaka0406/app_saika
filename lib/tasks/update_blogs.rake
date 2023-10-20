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

          ActiveRecord::Base.establish_connection(
            adapter: 'postgresql',
            encoding: 'unicode',
            pool: 5,
            username: 'aika_app_db_28fl_user',
            password: ENV['production_DB_PASSWORD'],
            host: 'localhost',
            database: 'saika_app_db_28fl'
            )

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
  