require_relative '../lib/mairie_christmas'

#----- VARIABLES -------
url = "https://www.annuaire-des-mairies.com/val-d-oise.html"

#----- TESTS -------
describe "the concat_url fonction" do
    it "should return count of concat_url fonction" do
        expect(concat_url.count).to eq(185)
    end
    it "should return the entire url of a city page" do
        expect(concat_url.include?("https://www.annuaire-des-mairies.com/95/bellefontaine.html")).to eq(true)
        expect(concat_url.include?("https://www.annuaire-des-mairies.com/95/jagny-sous-bois.html")).to eq(true)
        expect(concat_url.include?("https://www.annuaire-des-mairies.com/sarcelles.html")).to eq(false)
    end
end

describe "the scrapping_town(url) fonction" do
    it "should return the end of the url of a city page" do
        expect(scrapping_town(url).include?("/95/jagny-sous-bois.html")).to eq(true)
    end
    end

    describe "the final(concat_url) fonction" do
        it "should return an array of hashes with the city name (key) and email (value)" do
            expect(final(concat_url)[0].include?("ABLEIGES")).to eq(true)
            expect(final(concat_url)[184].include?("WY-DIT-JOLI-VILLAGE")).to eq(true)
            expect(final(concat_url)[10].include?("WY-DIT-JOLI-VILLAGE")).to eq(false)
        end
end