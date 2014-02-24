module RubyCoin
  module Worldcoin
    class Address < RubyCoin::Address
      def initialize(*args)
        super(CURVE_TYPE, *args)
      end

      def address
        encode_address
      end

      def version_hash(hex)
        PUBKEY_VER + hash160(hex)
      end

      def private_key
        key = compressed? ? @private_key + '01' : @private_key
        hex = PRIKEY_VER + key
        sum = checksum(hex)

        number_to_base((hex + sum).to_i(16), ADDR_CHARS)
      end

      private
        def encode_address
          hash = version_hash(public_key)
          sum  = checksum(hash)
          number_to_base((hash + sum).to_i(16), ADDR_CHARS)
        end
    end
  end
end
