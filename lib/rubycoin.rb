require 'digest/sha2'
require 'digest/rmd160'
require 'openssl'

require_relative 'ruby_coin/version'
require_relative 'ruby_coin/base'

module RubyCoin
end

RubyCoin.autoload :Bitcoin,  './ruby_coin/bitcoin'
RubyCoin.autoload :Litecoin, './ruby_coin/litecoin'
RubyCoin.autoload :Peercoin, './ruby_coin/peercoin'

# Monkeypatch OpenSSL for utility methods
module ::OpenSSL
  class BN
    # def self.from_hex(hex); new(hex, 16); end
    def to_hex; to_i.to_s(16); end
    # def to_mpi; to_s(0).unpack("C*"); end
  end
  class PKey::EC
    # def private_key_hex; private_key.to_hex.rjust(64, '0'); end
    # def public_key_hex;  public_key.to_hex.rjust(130, '0'); end
    # def pubkey_compressed?; public_key.group.point_conversion_form == :compressed; end
  end
  class PKey::EC::Point
    # def self.from_hex(group, hex)
    #   new(group, BN.from_hex(hex))
    # end
    def to_hex; to_bn.to_hex; end
    # def self.bn2mpi(hex) BN.from_hex(hex).to_mpi; end
  end
end
