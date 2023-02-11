require 'cocos'
require 'pixelart'


name = 'ordinalpenguins'
width, height = [35,35]


recs = read_csv( "./#{name}/ordinals.csv" )
puts "  #{recs.size} record(s)"

recs.each_with_index do |rec,i|
  id  = rec['id']
  num = rec['num']

  path = "./#{name}/i/#{num}.png"

  img = Image.read( path )

  ## steps = Image.calc_sample_steps( 192, 24 )
  steps = Image.calc_sample_steps( 192, 35 )

  img = img.sample( steps, steps )
  img.save( "./#{name}/#{width}x#{height}/#{num}.png" )
end


puts "bye"