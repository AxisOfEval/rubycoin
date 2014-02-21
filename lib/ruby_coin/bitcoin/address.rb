module RubyCoin
  module Bitcoin
    class Address < RubyCoin::Base
      attr_reader :address, :hash160, :checksum

      def initialize(seed = CURVE_TYPE, *args)
        super(seed, *args)

        @hash160  = Digest::RMD160.hexdigest(
          Digest::SHA256.digest(
            [public_key].pack('H*')
        ))

        @checksum = Digest::SHA256.hexdigest(
          Digest::SHA256.digest(
            [network_byte + hash160].pack('H*')
        ))[0...8]

        @address  = '1' + number_to_base(
          (network_byte + hash160 + checksum).to_i(16), ADDR_CHARS
        )
      end

      def to_s
        @address
      end

      def compressed_public_key
        # TODO: Optimize y-coord parity checking
        curve.public_key.y.to_i(16).even? ?
          '02' + curve.public_key.x.rjust(32, '0') :
          '03' + curve.public_key.x.rjust(32, '0')
      end

      def private_key
        return @btc_key unless @btc_key == nil

        hex_str   = private_key_version + @private_key
        checksum  = Digest::SHA256.hexdigest(
          Digest::SHA256.digest(
            [hex_str].pack('H*')
        ))[0...8]
        @btc_key  = number_to_base(
          (hex_str + checksum).to_i(16), ADDR_CHARS
        )
      end

      protected
        def network_byte
          '00'
        end

        def private_key_version
          '80'
        end
    end
  end
end
