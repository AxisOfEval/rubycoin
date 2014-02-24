require 'digest/sha2'
require 'digest/rmd160'
require 'openssl'

require_relative 'ruby_coin/version'
require_relative 'ruby_coin/address'

module RubyCoin
end

require_relative 'ruby_coin/bitcoin'
require_relative 'ruby_coin/litecoin'
require_relative 'ruby_coin/peercoin'
require_relative 'ruby_coin/dogecoin'
require_relative 'ruby_coin/namecoin'
require_relative 'ruby_coin/feathercoin'
require_relative 'ruby_coin/primecoin'
require_relative 'ruby_coin/megacoin'
require_relative 'ruby_coin/worldcoin'

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
