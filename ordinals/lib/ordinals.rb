
require 'cocos'
require 'pixelart'

require 'optparse'



## our own code
require_relative 'ordinals/collection'



module Ordinals
class Tool

  def self.main( args=ARGV )
    puts "==> welcome to ordinals/ordbase tool with args:"
    pp args

    options = {
              }

    parser = OptionParser.new do |opts|

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    parser.parse!( args )
    puts "options:"
    pp options

    puts "args:"
    pp args

    if args.size < 1
      puts "!! ERROR - no collection found - use <collection> <command>..."
      puts ""
      exit
    end

    slug             = args[0]
    command          = args[1] || 'image'

    if ['i','img', 'image'].include?( command )
      do_download_images( slug )
    elsif ['conv','convert'].include?( command )
      do_convert_images( slug )
    elsif ['px','pixelate' ].include?( command )
      do_pixelate( slug )
    elsif ['comp','composite' ].include?( command )
      do_make_composite( slug )
    else
      puts "!! ERROR - unknown command >#{command}<, sorry"
    end

    puts "bye"
  end



  def self.do_download_images( slug )
    puts "==> download images for collection >#{slug}<..."

    col = Collection.new( slug )
    col.download_images
  end


  def self.do_convert_images( slug )
    puts "==> convert images for collection >#{slug}<..."

    col = Collection.new( slug )
    col.convert_images
  end

  def self.do_pixelate( slug )
    puts "==> downsample / pixelate images for collection >#{slug}<..."

    col = Collection.new( slug )
    col.pixelate
  end

  def self.do_make_composite( slug )
    puts "==> make composite for collection >#{slug}<..."

    col = Collection.new( slug )
    col.make_composite
  end

end  # class Tool
end   # module Ordinals
