require 'cocos'
require 'pixelart'

# name = 'ordinalpenguins'
# width, height = [35, 35]
name  = 'yetibitclub'
width, height = [28,28]



recs = read_csv( "./#{name}/ordinals.csv" )
puts "  #{recs.size} record(s)"

composite = ImageComposite.new( 11, 11, width:  width,
                                        height: height )

recs.each_with_index do |rec,i|
  id  = rec['id']
  num = rec['num']

  path = "./#{name}/#{width}x#{height}/#{num}.png"
  img = Image.read( path )

  composite << img
end

composite.save( "./tmp/#{name}.png" )

puts "bye"