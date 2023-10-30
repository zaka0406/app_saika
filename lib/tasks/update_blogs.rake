namespace :update_blogs do
  desc "Update blogs from RSS feed"
  task fetch: :environment do
    # 本番環境で実行する
    ENV['RAILS_ENV'] = 'production'
 
    require 'httparty'
    require 'nokogiri'
  
    # RSSフィードのURLを指定
    feed_url = "http://rssblog.ameba.jp/chi-harusora/rss20.xml"
  
    begin
      # フィードを取得
      response = HTTParty.get(feed_url)
  
      if response.code == 200
        doc = Nokogiri::XML(response.body)
  
        doc.xpath('//item').each do |item|
          title = item.at('title').text
          content = item.at('description').text
          published_at = item.at('pubDate').text
          theme = item.at('category')&.text || 'デフォルトのテーマ'
          url = item.at('link').text || "デフォルトのURL"

          # 重複データがないか確認
          unless Blog.exists?(url: url)
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
    rescue StandardError => e
      # エラーハンドリング: エラーが発生した場合の処理
      puts "エラー: #{e.message}"
    end
  end
end
