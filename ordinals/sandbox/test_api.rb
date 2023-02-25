#################################
# to run use:
#
#  $ ruby sandbox/test_api.rb

$LOAD_PATH.unshift( "./lib" )
require 'ordinals'


content = Ordinals.bitcoin.content( 'c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0ai0' )
pp content


puts "bye"