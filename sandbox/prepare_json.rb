require 'cocos'

# name  = 'ordinalinsiders'
# name = 'bitcoinpizzas'
# name = 'toshians'
name = 'frenless'


data = read_json( "./#{name}/inscriptions.json" )

puts "  #{data.size} record(s)"


ids = []
data.each do |rec|
  ids << rec['id']
end

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
