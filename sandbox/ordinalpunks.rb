require 'cocos'


data = read_json( "./tmp/ordinalpunks.json" )
pp data


items = data['items']
puts "  #{items.size} item(s)"
#=>  100 item(s)


items.each_with_index do |rec,i|

  if rec['collection_item_id'].to_i(10) != i+1
     puts "!! ERROR - item out-of-order - expected #{i}, got:"
     pp rec
     exit 1
  end


  attributes = rec['attributes'].map{ |h| h['value'] }
  type        = attributes[0]
  accessories = attributes[1..-1]

  puts "#{i+1},  #{type},  #{accessories.count},  #{accessories.join(' / ')}"

end


puts "bye"