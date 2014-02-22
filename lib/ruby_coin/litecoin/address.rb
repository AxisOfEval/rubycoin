module RubyCoin
  module Litecoin
    class Address < RubyCoin::Address
      def initialize(*args)
        super(CURVE_TYPE, *args)

        curve.instance_variable_set(:@_pubkey_version, '30')
        curve.instance_variable_set(:@_prikey_version, 'b0')
      end

      def address
        encode_address
      end

      def private_key
        key = compressed? ? @private_key + '01' : @private_key
        hex = private_key_version + key
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
