require 'yahoo_finance_option_crawler'

class OptionWatcher
  TICKER_LIST = ["HIMX","NQ","QIHU","SCTY","CTRP","VIPS","QUNR","KNDI","BIDU","WUBA","ATHM","DANG","YOKU","FB","TSLA","CCIH","YY","SFUN","YGE","FSLR","GTAT" ]
  #watch but not stored
  def self.watch
    huge_vol_list = []
    crawler = YahooFinanceOptionCrawler.new
    TICKER_LIST.each do |ticker|
      random_sleep
      crawler.fetch(ticker)
      near_options = crawler.extract_option_data
      near_options.each{|op| op.save}
      huge_vol_list += near_options.select{|op| op.turnover >= 100 * 10000 }

      crawler.extract_option_month.each do |mon|
        random_sleep
        crawler.fetch(ticker, mon)
        far_options = crawler.extract_option_data
        far_options.each{|op| op.save}
        huge_vol_list += far_options.select{|op| op.turnover >= 100 * 10000 }
      end
    end

    if huge_vol_list.any?
      StockMailer.big_vol_mail(huge_vol_list)
    end
  end

  def self.random_sleep
    sleep(rand()*2)
  end
end
