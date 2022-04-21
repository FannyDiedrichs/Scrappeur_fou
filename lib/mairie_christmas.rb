require 'nokogiri'
require 'open-uri'

=begin #--------MAIRIE AVERNES

page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/95/avernes.html"))

email_avernes = page.xpath("/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]")
name_avernes = page.xpath("/html/body/div[1]/main/section[1]/div/div/div/p[1]/strong[1]/a")


def get_townhall_email(url, name)
    arr_email = []
    email = url.text
    ville = name.text
    hash = {
        "#{ville}" => "#{email}"
    }
    arr_email << hash
    return  arr_email
end

get_townhall_email(email_avernes, name_avernes)
=end
#--------URL DE TOUTES LES MAIRIES du 95

def scrapping_town(url)
    html = URI.open("#{url}").read
    nokogiri_doc = Nokogiri::HTML(html)
    arr = []
    nokogiri_doc.search(".lientxt").each do |element|
        arr << element.attributes["href"].value.gsub("./", "/")
    end
    return arr
end


# FONCTION : Concatène les liens de chaque ville (fonction précedente) ---> /95/vaudherland.html
#            avec le lien global ---> https://www.annuaire-des-mairies.com/
def concat_url
    city_link = scrapping_town("https://www.annuaire-des-mairies.com/val-d-oise.html")
    url_list = []
    city_link.each do |link|
    url_list << "https://www.annuaire-des-mairies.com#{link}"
    end
    return url_list
end

#array des mails

# LISTE DES NOMS ET EMAILS À PARTIR DES URL

def final(liens)
    link_parse = []
    email_city = []
    name_city = []

    liens.each do |lien|
        link_parse << Nokogiri::HTML(URI.open(lien))
    end

    link_parse.each do |lien|
        email_city << lien.xpath("/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]").text
        name_city << lien.xpath("/html/body/div[1]/main/section[1]/div/div/div/p[1]/strong[1]/a").text
    end
        my_hash = name_city.zip(email_city).to_h
        city_name_email = my_hash.map {|name,email| {name => email}}
        return city_name_email
end

puts "Le chargement peut prendre quelques secondes...."
puts final(concat_url)