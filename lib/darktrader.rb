require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))  

all_crypto_indice = page.xpath('//tbody/tr/td/div[@class="sc-131di3y-0 cLgOOr"]/a/span')
all_crypto_symbol = page.xpath('//tbody/tr/td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]/div')

def method_trader (path_indice, path_symbol)
    arr1 = []
    arr2 = []   
    path_indice.each do |indice|
        arr1 << indice.text
    end

    path_symbol.each do |symbol|
        arr2 << symbol.text
    end
    my_hash = Hash[arr2.zip(arr1)].to_h 
    arr3 = my_hash.map {|symbol, price| {symbol => price}}
    return arr3
end

def calc_count(fonction)
    return fonction.count
end

calc_count(method_trader(all_crypto_indice, all_crypto_symbol))
puts method_trader(all_crypto_indice,all_crypto_symbol) 

