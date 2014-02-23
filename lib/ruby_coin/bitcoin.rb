require_relative 'bitcoin/address'

module RubyCoin
  module Bitcoin
    CURVE_TYPE = 'secp256k1'
    ADDR_CHARS = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
    PUBKEY_VER = '00'
    PRIKEY_VER = '80'
  end
end
