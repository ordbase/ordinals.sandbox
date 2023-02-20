require 'cocos'


data = read_json( "./tmp/ordinalpunks.patch.json" )
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


## get attribute counts my categories

stats = { 'Type' => { 'm' => Hash.new(0),
                      'f' => Hash.new(0)}}


items.each_with_index do |rec,i|

  ## note: assume first entry is Type
  type = rec['attributes'][0]['value']

  gender = type.downcase.index( 'female' ) ?  'f' : 'm'


  rec['attributes'].each do |h|
      key   = h['trait_type']
      value = h['value']

      if key == 'Type'
        stat = stats[ key ][ gender ]
        stat[ value ]  += 1
      else
        category = stats[ key ] ||= {}
        stat     = category[ value ] ||= { 'm' => 0,
                                           'f' => 0 }
        stat[ gender ] += 1
      end
  end
end

pp stats




puts "bye"