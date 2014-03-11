class Option < ActiveRecord::Base
  self.inheritance_column = nil
  attr_accessible :ask, :bid, :last, :open_int, :strike, :symbol, :type, :vol, :expiration

  def to_s
    "| #{symbol} | #{type} | #{expiration} | strike:#{strike} | last:#{last} | bid:#{bid} | ask:#{ask} | vol:#{vol} | open_int:#{open_int} | #{turnover} |"
  end

  def turnover
    last * vol * 100
  end
end
