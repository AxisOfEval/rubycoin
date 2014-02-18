module Rubycoin
  def self.version
    Gem::Version.new '0.0.1'
  end

  module VERSION #:nodoc:
    MAJOR, MINOR, TINY, PRE = Rubycoin.version.segments
    STRING = Rubycoin.version.to_s
  end
end
