require 'rubygems'
require 'mechanize'
require 'digest/md5'

class YahooFinanceOptionCrawler

  def initialize
    @agent = Mechanize.new do |agent|
      agent.user_agent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.168 Safari/535.19"
      agent.max_history = 1
    end
  end

  def fetch(ticker, month=nil)
    @ticker = ticker
    @month = month
    target_page_url = "http://finance.yahoo.com/q/op?s=#{@ticker}&m=#{@month}"
    puts target_page_url
    @option_page = @agent.get(target_page_url)
  end

#  def fetch(link)
#    @option_page = @agent.click(link)
#  end

  def extract_option_month
    @option_page.search("#yfncsumtab a").select{|ar| ar.attr('href')=~/\/q\/op\?s=[A-Z]+&m=/}.collect{|ar| ar.attr('href').match(/&m=(.+)/)[1]}
  end

  def extract_option_data
    option_records = []
    data = @option_page.search(".yfnc_datamodoutline1 table tr")
    if data.size == 0
      raise "can not find option table for ticker #{@ticker}"
    elsif data[0].text() != "StrikeSymbolLastChgBidAskVolOpen Int"
      raise "option table format is changed!"
    else
      data.reject{|row| row.search("td").size == 0}.each do |row|
        cells = row.search("td")
        option = Option.new
        option.strike = cells[0].text().to_f
        option.symbol = @ticker.upcase
        option.last = cells[2].text().to_f
        option.bid = cells[4].text().to_f
        option.ask = cells[5].text().to_f
        option.vol = cells[6].text().gsub(/,/,"").to_i
        option.open_int = cells[7].text().gsub(/,/,"").to_i
        yh_symbol = cells[1].text()
        expiration_type_price = yh_symbol.sub(@ticker.upcase,"")
        if expiration_type_price =~ /C/
          option.type = "call"
        elsif expiration_type_price =~ /P/
          option.type = "put"
        end
        option.expiration = Date.parse(expiration_type_price.split(/[PC]/)[0])
        option_records.push option
      end
    end
    return option_records
  end

  

end
