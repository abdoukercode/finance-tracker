class Stock < ApplicationRecord

    def self.find_by_ticker(symbol)
        where(ticker: symbol).first
        
    end

    def self.new_from_lookup(symbol)
        looked_up_stock = StockQuote::Stock.quote(symbol)
        return nil unless looked_up_stock.name

        new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
        new_stock.last_price = new_stock.price
        new_stock

    end
    def price
        closing_price = StockQuote::Stock.quote(ticker).close
        return '#{closing_price} (closing)' if closing_price

        opening_price = StockQuote::Stock.quote(ticker).open
        return "#{opening_price} (Opening)" if opening_price
        'Unavailble'
    end
end
 