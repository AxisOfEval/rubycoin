module RubyCoin
  def self.version
    Gem::Version.new '0.0.6'
  end

  module VERSION #:nodoc:
    MAJOR, MINOR, TINY, PRE = RubyCoin.version.segments
    STRING = RubyCoin.version.to_s
  end
end
