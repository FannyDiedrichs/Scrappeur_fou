require_relative '../lib/darktrader'

#----- VARIABLES -------
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
all_crypto_indice = page.xpath('//tbody/tr/td/div[@class="sc-131di3y-0 cLgOOr"]/a/span')
all_crypto_symbol = page.xpath('//tbody/tr/td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]/div')


#----- TESTS -------
describe "the crypto" do
    it "should return the result of fonction calc_count" do
        expect(calc_count(method_trader(all_crypto_indice, all_crypto_symbol))).to eq(20)
        expect(calc_count(method_trader(all_crypto_indice, all_crypto_symbol)) > 10).to eq(true)
    end
end

describe "the crypto" do
    it "should return the crypto by index" do
        expect(method_trader(all_crypto_indice,all_crypto_symbol)[1].first[0]).to eq("ETH")
        expect(method_trader(all_crypto_indice,all_crypto_symbol)[0].first[0]).to eq("BTC")
    end
end

describe "the crypto" do
    it "should return true if the crypto is included and false if isnt included" do
        expect(method_trader(all_crypto_indice,all_crypto_symbol)[1].include?("ETH")).to eq(true)
        expect(method_trader(all_crypto_indice,all_crypto_symbol)[6].include?("SOL")).to eq(true)
        expect(method_trader(all_crypto_indice,all_crypto_symbol)[12].include?("CRO")).to eq(false)
    end
end