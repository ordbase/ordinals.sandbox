
require 'cocos'
require 'pixelart'

require 'optparse'


## add nokogiri for api (html parsing)
require 'nokogiri'





module Ordinals
  class Configuration

    #######################
    ## accessors
    def chain=(value)
        if value.is_a?( String ) || value.is_a?( Symbol )
            case value.downcase.to_s
            when 'btc', 'bitcoin', 'bitcon'
               @chain  = 'btc'
               @client = Ordinals::Api.bitcoin
            when 'ltc', 'litecoin', 'litecon'
               @chain = 'ltc'
               @client = Ordinals::Api.litecoin
            else
              raise ArgumentError, "unknown chain - expected btc | ltc; got #{value}"
            end
        else
            raise ArgumentError, "only string or symbol supported for now; sorry - got: #{value.inspect} : #{value.class.name}"
        end
    end

    def chain
      ## note - default to btc/bitcon if not set
      self.chain = 'btc'   unless defined?( @chain )
      @chain
    end

    ## note: read-only for now - why? why not?
    def client
      ## note - default to btc/bitcon if not set
      self.chain = 'btc'   unless defined?( @client )
      @client
    end
  end # class Configuration


  ## lets you use
  ##   Ordinals.configure do |config|
  ##      config.chain = :btc
  ##   end
  def self.configure() yield( config ); end
  def self.config()    @config ||= Configuration.new;  end

  ##  add some convenience shortcut helpers (no config. required) - why? why not?
  def self.client()   config.client; end
  def self.chain()    config.chain; end

  def self.btc?()     config.chain == 'btc'; end
  def self.ltc?()     config.chain == 'ltc'; end
  class << self
    alias_method :bitcoin?, :btc?
    alias_method :bitcon?,  :btc?

    alias_method :litecoin?, :ltc?
    alias_method :litecon?,  :ltc?
  end
end  # module Ordinals




## our own code
require_relative 'ordinals/api'
require_relative 'ordinals/collection'
require_relative 'ordinals/stats'

require_relative 'ordinals/tool'



