module RubyCoin
  module Namecoin
    class Address < RubyCoin::Address
      def initialize(*args)
        super(CURVE_TYPE, *args)

        curve.instance_variable_set(:@_pubkey_version, '34')
        curve.instance_variable_set(:@_prikey_version, '80')
      end

      def address
        encode_address
      end

      def compressed_public_key
        # TODO: Optimize y-coord parity checking
        curve.public_key.y.to_i(16).even? ?
          '02' + curve.public_key.x.rjust(32, '0') :
          '03' + curve.public_key.x.rjust(32, '0')
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
