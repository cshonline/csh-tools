class StockMailer < ActionMailer::Base
  default from: "StockWatcher<cshonline@163.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.stock_mailer.big_vol_mail.subject
  #
  def big_vol_mail(option_data)
    @options_data = option_data
    ["cshonline@gmail.com","lastarsenal@163.com","liuyg1025@163.com"].each do |addr|
      mail(to: addr, subject: "BigVolOptions").deliver
    end
  end
end
