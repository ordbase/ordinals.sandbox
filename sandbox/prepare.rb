require 'cocos'


## get image links
## e.g.
##   <img class="img-fluid" src="https://ordinals.com/content/0cc4000a34b8549afd96b48b78a0d491c541618b2b1f2e0364a48f2d9cccc8cei0">
##
##  and export as tabular dataset (in .csv)

##
##  /inscription/1ac93a80cd4b0956afcccfde071124ca13db711e802c2cae534abc91353b303ai0


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
# name = 'cyberordinals'
# name = 'ordinalkitties'
# name = 'pixelpepes'
# name = 'hiddensociety'
# name = 'rightclickinscribe'
name = 'hoodiegang'

txt = read_text( "./#{name}/page.txt" )



##
##  https://turbo.ordinalswallet.com/inscription/content/7b4621462d4b1ce59045950774c9f4f82c1fac0fa8c5838a2a5bc6b6d06705dfi0
##

##
##  /ordinals/item-details/4c9ecd091a011e6e157b3ff0d49e0a0ef1d759310fb44b8d7ddeeb8867f2adf2i0

##
##  <a class="tw-flex tw-justify-between
##           tw-min-w-0 tw-text-secondary tw-text-[16px]
##           tw-truncate tw-w-[100%]" title="#9"
##           href="/ordinals/item-details/4c9ecd091a011e6e157b3ff0d49e0a0ef1d759310fb44b8d7ddeeb8867f2adf2i0">
##                   Hoodie Gang Member #9
##              </a>


IMG_RX = %r{
             <img
                .+?
                src="(?<link>[^"]+)"
                .*?
              >
            }ix

LINK_RX = %r{
              inscription/
                 (?<link>[a-fi0-9]+)
            }ix

MAGICEDEN_LINK_RX = %r{  <a
                              .+?
                              title="(?<title>[^"]+)"
                                .+?
                               href="(?<link>[^"]+)"
                                .*?
                              >
                              }ix


links = []


# rx = IMG_RX
rx = MAGICEDEN_LINK_RX
txt.scan( rx ) do |_|
  m = Regexp.last_match

  links << [m[:title].strip,
            m[:link].strip]

end

def numify( str )
  str.gsub( /[ #]/, '' ).to_i(10)
end

links = links.sort do |l,r|
                         numify( l[0] ) <=> numify( r[0] )
                   end

pp links

puts "   #{links.size} link(s)"

__END__

ids = links.map { |link|  link.split('/')[-1] }
pp ids
puts "   #{ids.size} id(s)"


## turn into symbol (to make uniq work)
ids = ids.uniq
pp ids
puts "   #{ids.size} id(s)"



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
