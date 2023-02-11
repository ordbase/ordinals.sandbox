require 'cocos'
require 'pixelart'


recs = read_csv( "./ordinalpunks/ordinals.csv" )
puts "  #{recs.size} record(s)"

composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )

recs.each_with_index do |rec,i|
  id  = rec['id']
  num = rec['num']

  path = "./ordinalpunks/24x24/#{num}.png"
  img = Image.read( path )

  composite << img
end

composite.save( "./tmp/ordinalpunks.png" )

puts "bye"