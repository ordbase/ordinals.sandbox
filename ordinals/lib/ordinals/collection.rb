
module Ordinals


class Collection
  attr_reader :slug,
              :width, :height,
              :sources


  def initialize( slug )
      @slug = slug

      ## read config if present
      config_path = "./#{@slug}/collection.yml"
      if File.exist?( config_path )
        config = read_yaml( config_path )
        pp config

        @width, @height = _parse_dimension( config['format'] )

        ## note: allow multiple source formats / dimensions
        ### e.g. convert   512x512 into  [ [512,512] ]
        ##
        source = config['source']
        source = [source]  unless source.is_a?( Array )
        @sources = source.map { |dimension| _parse_dimension( dimension ) }
      end
  end


def ordinals
   @ordinals ||= begin
                     recs = read_csv( "./#{@slug}/ordinals.csv" )
                     puts "  #{recs.size} record(s)"
                     recs
                 end
   @ordinals
end

def count() ordinals.size; end
alias_method :size, :count



def each_ordinal( &block )
  ordinals.each do |rec|   ## pass along hash rec for now - why? why not?
    block.call( rec )
  end
end

## add each_source_image or each_token_image or each_original_image or such - why? why not??



def each_image( &block )
  each_ordinal do |rec|
    id  = rec['id']
    num = rec['num'].to_i(10)

    path = "./#{@slug}/#{@width}x#{@height}/#{num}.png"
    img = Image.read( path )

    block.call( img, num )
  end
end



def image_dir()  "./#{@slug}/token-i";  end



## e.g. convert dimension (width x height) "24x24" or "24 x 24" to  [24,24]
def _parse_dimension( str )
    str.split( /x/i ).map { |str| str.strip.to_i }
end


def pixelate
  each_ordinal do |rec|
    id  = rec['id']
    num = rec['num']

    outpath = "./#{@slug}/#{@width}x#{@height}/#{num}.png"
    next if File.exist?( outpath )

    path = "#{image_dir}/#{num}.png"
    puts "==> reading #{path}..."

    img = Image.read( path )
    puts "   #{img.width}x#{img.height}"

    ## check for source images
    if !@sources.include?( [img.width, img.height] )
      puts "  !! ERROR - unexpected image size; sorry - expected:"
      pp @sources
      exit 1
    end

    ## check for special case   source == format!!
    if [img.width,img.height] == [@width,@height]
      puts "   note: saving image as is - no downsampling"
      img.save( outpath )
    else
      steps_x = Image.calc_sample_steps( img.width, @width )
      steps_y = Image.calc_sample_steps( img.height, @height )

      img = img.sample( steps_x, steps_y )
      img.save( outpath )
    end
  end
end


def make_composite
  cols, rows = case count
               when    10 then   [5,   2]
               when    12 then   [4,   3]
               when    15 then   [5,   3]
               when    20 then   [5,   4]
               when    69 then   [10,  7]
               when    80 then   [10,  8]
               when    88 then   [10,  9]
               when    99 then   [10,  10]
               when   100 then   [10,  10]
               when   111 then   [11,  11]
               when   130 then   [10,  13]
               when   512 then   [20,  26]
               else
                   raise ArgumentError, "sorry - unknown composite count #{count} for now"
               end

  composite = ImageComposite.new( cols, rows,
                                  width:  @width,
                                  height: @height )


  each_image do |img, num|
    puts "==> #{num}"
    composite << img
  end

   composite.save( "./#{@slug}/tmp/#{@slug}.png" )
end



def convert_images
  Image.convert( image_dir, from: 'jpg',
                            to:   'png' )

  Image.convert( image_dir, from: 'gif',
                            to:   'png' )

  Image.convert( image_dir, from: 'webp',
                            to:   'png' )

#  Image.convert( image_dir, from: 'png',
#                            to:   'png' )
end


def download_images
  each_ordinal do |rec|
    id  = rec['id']
    num = rec['num']

    next if File.exist?( "#{image_dir}/#{num}.png" )

    puts "==> downloading image ##{num}..."

    image_url = "https://ordinals.com/content/#{id}"

    res = Webclient.get( image_url )

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
               elsif content_type =~ %r{image/webp}i
                 'webp'
               else
                 puts "!! ERROR:"
                 puts " unknown image format content type: >#{content_type}<"
                 exit 1
               end

      ## save image - using b(inary) mode
      write_blob( "#{image_dir}/#{num}.#{format}", res.blob )

      sleep( 1.0 )  ## sleep (delay_in_s)
    else
      puts "!! ERROR - failed to download image; sorry - #{res.status.code} #{res.status.message}"
      exit 1
    end
  end
end

end   # class Collection
end   # module Ordinals

