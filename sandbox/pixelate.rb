require 'cocos'
require 'pixelart'


recs = read_csv( "./ordinal-punks/ordinals.csv" )
puts "  #{recs.size} record(s)"

recs.each_with_index do |rec,i|
  id  = rec['id']
  num = rec['num']

  path = "./ordinal-punks/i/#{num}.png"

  img = Image.read( path )

  steps = Image.calc_sample_steps( 192, 24 )

  img = img.sample( steps, steps )
  img.save( "./ordinal-punks/24x24/#{num}.png" )
end


puts "bye"