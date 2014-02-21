require 'digest/sha2'
require 'digest/rmd160'
require 'openssl'

require_relative 'ruby_coin/version'
require_relative 'ruby_coin/base'

module RubyCoin
end

require_relative 'ruby_coin/bitcoin'
require_relative 'ruby_coin/litecoin'
require_relative 'ruby_coin/peercoin'
require_relative 'ruby_coin/dogecoin'

# Monkeypatch OpenSSL for utility methods
module ::OpenSSL
  class BN
    def to_hex; to_i.to_s(16).rjust(64, '0'); end
  end

  class PKey::EC
    attr_reader :_pubkey_version, :_prikey_version
  end

  class PKey::EC::Point
    def to_hex; to_bn.to_i.to_s(16).rjust(130, '0'); end
    def x; to_hex[2..65];   end
    def y; to_hex[66..130]; end
  end
end

btc = RubyCoin::Bitcoin::Address.new
puts btc.address
puts btc.private_key
# puts
# puts btc.instance_variable_get(:@public_key)
# puts btc.public_key
# puts
# puts btc.curve.public_key.x
# puts btc.curve.public_key.y
# puts
# puts btc.curve.public_key.x_new
# puts btc.curve.public_key.y_new
# puts btc.curve.public_key.to_hex
