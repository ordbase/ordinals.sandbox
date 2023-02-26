require 'cocos'


## calculate some statis

base_dir = "../../ordinals.cache"


datasets = Dir.glob( "#{base_dir}/inscription/*.json" )

puts "  #{datasets.size} inscription(s)"


TITLE_RX = /^Inscription[ ]+(?<ord>[0-9]+)$/
BYTES_RX = /^(?<bytes>[0-9]+)[ ]+bytes$/


stats = {
  ord: { '<1000'  => 0,
         '<10000' => 0,
         '<100000' => 0,
         '<1000000' => 0 },
  type: Hash.new(0),
  bytes:  {  '<100'  => 0,
             '<1000' => 0,
             '<10000' => 0,
             '<100000' => 0,
             '<1000000' => 0 },
}


days = Hash.new(0)

datasets.each do |path|
  data = read_json( path )

  ord = nil
  if m=TITLE_RX.match( data['title'] )
      ord = m[:ord].to_i(10)
  else
      puts "!! ERROR - cannot find ord in inscription title; sorry"
      pp data
      exit 1
  end

  if     ord < 1000    then  stats[:ord]['<1000'] += 1
  elsif  ord < 10000   then  stats[:ord]['<10000'] += 1
  elsif  ord < 100000  then  stats[:ord]['<100000'] += 1
  elsif  ord < 1000000 then  stats[:ord]['<1000000'] += 1
  else
    puts "!! ERROR ord out-of-bounds"
    exit 1
  end


  bytes = nil
  if m=BYTES_RX.match( data['content length'] )
      bytes = m[:bytes].to_i(10)
  else
      puts "!! ERROR - cannot find bytes in inscription content length; sorry"
      pp data
      exit 1
  end

  if     bytes < 100     then  stats[:bytes]['<100'] += 1
  elsif  bytes < 1000    then  stats[:bytes]['<1000'] += 1
  elsif  bytes < 10000   then  stats[:bytes]['<10000'] += 1
  elsif  bytes < 100000  then  stats[:bytes]['<100000'] += 1
  elsif  bytes < 1000000 then  stats[:bytes]['<1000000'] += 1
  else
    puts "!! ERROR bytes (content-length) out-of-bounds"
    exit 1
  end


  type = data['content type']

  stats[:type][ type ] += 1

  ## "timestamp"=>"2023-02-05 01:45:22 UTC",
  ts = Time.strptime( data['timestamp'], '%Y-%m-%d %H:%M:%S' )

  days[ ts.strftime('%Y-%m-%d') ] +=1
end

## sort days
days = days.sort {|l,r|  l[0] <=> r[0] }
## add to stats
stats[:days] = {}
days.each {|k,v| stats[:days][k] = v }



pp stats

puts "  bye"
