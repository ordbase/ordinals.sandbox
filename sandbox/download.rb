require 'cocos'


# name = 'ordinalpenguins'
# name  = 'yetibitclub'
# name  = 'bitcoinbears'
# name = 'bitcoinpunks'
name = 'ordinalbirds'



recs = read_csv( "./#{name}/ordinals.csv" )
puts "  #{recs.size} record(s)"

recs.each_with_index do |rec,i|
  id  = rec['id']
  num = rec['num']

  next if File.exist?( "./#{name}/i/#{num}.png" )

  puts "==> downloading image ##{num}..."

  image_url = "https://ordinals.com/content/#{id}"

  res = wget( image_url )

  if res.status.ok?
     content_type   = res.content_type
     content_length = res.content_length

     puts "  content_type: #{content_type}, content_length: #{content_length}"

     format = if content_type =~ %r{image/jpeg}i
                'jpg'
              elsif content_type =~ %r{image/png}i
                'png'
              elsif content_type =~ %r{image/gif}i
                'gif'
              else
                puts "!! ERROR:"
                puts " unknown image format content type: >#{content_type}<"
                exit 1
              end

     ## save image - using b(inary) mode
     write_blob( "./#{name}/token-i/#{num}.#{format}", res.blob )

     sleep( 1.0 )  ## sleep (delay_in_s)
  else
     puts "!! ERROR - failed to download image; sorry - #{res.status.code} #{res.status.message}"
     exit 1
  end
end


puts "bye"