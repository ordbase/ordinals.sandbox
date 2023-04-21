$LOAD_PATH.unshift( '../pixelart/pixelart/lib' )
$LOAD_PATH.unshift( '../ordbase/ordinals/lib' )
$LOAD_PATH.unshift( '../ordbase/ordbase/lib' )


require 'ordbase'



###########
# start up tool if run via script (e.g. ruby ordbase.rb)

Ordinals::Tool.main   if __FILE__ == $0