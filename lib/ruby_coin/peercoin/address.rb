module RubyCoin
  module Peercoin
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

        @address  = number_to_base(
          (network_byte + hash160 + checksum).to_i(16), ADDR_CHARS
        )
      end

      def to_s
        @address
      end

      def private_key
        return @ppc_key unless @ppc_key == nil

        hex_str   = private_key_version + @private_key
        checksum  = Digest::SHA256.hexdigest(
          Digest::SHA256.digest(
            [hex_str].pack('H*')
        ))[0...8]
        @ppc_key  = number_to_base(
          (hex_str + checksum).to_i(16), ADDR_CHARS
        )
      end

      protected
        def network_byte
          '37'
        end

        def private_key_version
          'b7'
        end
    end
  end
end
