require 'cocos'


## get links
## e.g.
##   <img class="img-fluid" src="https://ordinals.com/content/0cc4000a34b8549afd96b48b78a0d491c541618b2b1f2e0364a48f2d9cccc8cei0">


# name  = 'ordinalpenguins'
# name  = 'yetibitclub'
# name  = 'bitcoinbears'
# name = 'bitcoinpunks'
name = 'ordinalbirds'


txt = read_text( "./#{name}/page.txt" )


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
