require 'cocos'


## get image links
## e.g.
##   <img class="img-fluid" src="https://ordinals.com/content/0cc4000a34b8549afd96b48b78a0d491c541618b2b1f2e0364a48f2d9cccc8cei0">
##
##  and export as tabular dataset (in .csv)



# name  = 'ordinalpenguins'
# name  = 'yetibitclub'
# name  = 'bitcoinbears'
# name = 'bitcoinpunks'
# name = 'ordinalbirds'
# name = 'inscribedpepes'
# name = 'extraordinalwomen'
# name = 'eldersofcrypto'
# name = 'ordinalminidoges'
# name = 'ordinalgoldbirds'
# name = 'ordinarypeople'
# name = 'taprootpunks'
# name = 'ordidoodles'
# name = 'bitcoingoblins'
# name = 'ordinalwaifus'
# name = 'shadowsmokers'
# name = 'bitcoinbandits'
# name = 'ordinaryapes'
# name = 'engraveddragons'
# name = 'popordinalcats'
# name = 'ordinalgoros'
# name = 'ordinalminis'
# name = 'ordinalphunks'
# name = 'forgottenpunks'
# name = 'gpunks'
# name = '1337ordinals'
# name = 'ordinalumekopunks'
# name = 'shadowhats'
# name = 'dogepunks'
# name = 'monkeykingdom'
# name = 'ordinalprimates'
# name = 'bitcoinapes'
name = 'cyberordinals'


txt = read_text( "./#{name}/page.txt" )



##
##  https://turbo.ordinalswallet.com/inscription/content/7b4621462d4b1ce59045950774c9f4f82c1fac0fa8c5838a2a5bc6b6d06705dfi0
##

IMG_RX = %r{
             <img
                .+?
                src="(?<link>[^"]+)"
                .*?
              >
            }ix


links = []



txt.scan( IMG_RX ) do |_|
  m = Regexp.last_match

  links << m[:link].strip

end


pp links
puts "   #{links.size} link(s)"


ids = links.map { |link|  link.split('/')[-1] }
pp ids
puts "   #{links.size} id(s)"


recs = []
ids.each_with_index do |id, i|
   recs << [(i+1).to_s, id]
end

headers = ['num', 'id']
buf = String.new('')
buf << headers.join( ', ' )
buf << "\n"
recs.each do |values|
  buf << values.join( ', ' )
  buf << "\n"
end


write_text( "./tmp/ordinals.csv", buf )

puts "bye"
