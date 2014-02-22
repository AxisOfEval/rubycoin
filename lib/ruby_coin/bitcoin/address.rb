module RubyCoin
  module Bitcoin
    class Address < RubyCoin::Base
      def initialize(seed = CURVE_TYPE, *args)
        super(seed, *args)

        curve.instance_variable_set(:@_pubkey_version, '00')
        curve.instance_variable_set(:@_prikey_version, '80')
      end

      def address
        '1' + encode_address
      end

      def encode_address
        hash = version_hash(public_key)
        sum  = checksum(hash)
        number_to_base((hash + sum).to_i(16), ADDR_CHARS)
      end

      def private_key
        key = compressed? ? @private_key + '01' : @private_key
        hex = private_key_version + key
        sum = checksum(hex)

        number_to_base((hex + sum).to_i(16), ADDR_CHARS)
      end
    end
  end
end
