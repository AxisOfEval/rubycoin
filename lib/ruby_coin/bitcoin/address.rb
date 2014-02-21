module RubyCoin
  module Bitcoin
    class Address < RubyCoin::Base
      def initialize(seed = CURVE_TYPE, *args)
        super(seed, *args)
      end

      def address
        '1' + encode_address
      end

      def encode_address
        hash = version_hash(public_key)
        sum  = checksum(hash)
        number_to_base((hash + sum).to_i(16), ADDR_CHARS)
      end

      def version_hash(hex)
        public_key_version + hash160(hex)
      end

      def compressed?
        false
      end

      def public_key
        case compressed?
        when true
          # TODO: Optimize y-coord parity checking
          curve.public_key.y.to_i(16).even? ?
            '02' + curve.public_key.x.rjust(32, '0') :
            '03' + curve.public_key.x.rjust(32, '0')
        else
          @public_key
        end
      end

      def private_key
        key = compressed? ? @private_key + '01' : @private_key
        hex = private_key_version + key
        sum = checksum(hex)

        number_to_base((hex + sum).to_i(16), ADDR_CHARS)
      end

      private
        def public_key_version
          '00'
        end

        def private_key_version
          '80'
        end
    end
  end
end
