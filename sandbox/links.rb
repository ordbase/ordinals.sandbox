require 'cocos'


## get links
## e.g.
##   <img class="img-fluid" src="https://ordinals.com/content/0cc4000a34b8549afd96b48b78a0d491c541618b2b1f2e0364a48f2d9cccc8cei0">


txt = read_text( "./ordinal-punks/page.txt" )


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

__END__

"https://ordinals.com/content/b8ce900663108e2e07994632722b01ba86dfaa37e6636080828262f719c99ef7i0",
"https://ordinals.com/content/80d6d0131f9d0c9ece3709b6dc4a74224387ce5b9b5afa27cf5f1dbcd797aa35i0",
"https://ordinals.com/content/0fd5af58c3fb2cd0afc212652e161054f1d2560735907542a2ce87509b070448i0",
"https://ordinals.com/content/a978cd5c0d725c30036089a47ea3cc3f113cb4d9b37207dbfcd00f2fd37ac8b0i0",
"https://ordinals.com/content/2cdb4d76b2ef360c810072e2a5efb683167743f0071470611bcce902657515dei0",
"https://ordinals.com/content/f4bb9a2e06098b04fafa933fbbb514e36c8f3f46d6e3f8336e4626d20886c5efi0",
"https://ordinals.com/content/0cc4000a34b8549afd96b48b78a0d491c541618b2b1f2e0364a48f2d9cccc8cei0"]
  100 link(s)