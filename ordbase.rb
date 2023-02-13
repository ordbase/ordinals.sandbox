$LOAD_PATH.unshift( '../pixelart/pixelart/lib' )
$LOAD_PATH.unshift( './ordinals/lib' )


require 'ordinals'



###########
# start up tool if run via script (e.g. ruby ordbase.rb)

Ordinals::Tool.main   if __FILE__ == $0