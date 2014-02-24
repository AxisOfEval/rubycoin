module RubyCoin
  class Address
    attr_accessor :curve, :private_key, :public_key, :compressed

    def initialize(seed, compressed=true, *args)
      self.curve  = ::OpenSSL::PKey::EC.new(seed, *args)

      @compressed = compressed 
      curve.generate_key
      curve.private_key? ? init_private_key : nil_private_key
      curve.public_key?  ? init_public_key  : nil_public_key
    end

    alias_method :secret, :private_key

    def to_s
      address
    end

    def compressed?
      @compressed
    end

    def public_key
      case @compressed
      when true
        # TODO: Optimize y-coord parity checking
        curve.public_key.y.to_i(16).even? ?
          '02' + curve.public_key.x.rjust(32, '0') :
          '03' + curve.public_key.x.rjust(32, '0')
      else
        @public_key
      end
    end

    protected
      def hash160(hex)
        Digest::RMD160.hexdigest(Digest::SHA256.digest([hex].pack('H*')))
      end

      def checksum(hex)
        Digest::SHA256.hexdigest(
          Digest::SHA256.digest(
            [hex].pack('H*')
        ))[0...8]
      end

      def number_to_base(number, alpha)
        string, base = '', alpha.size
        while(number >= base)
          mod       = number % base
          string    = alpha[mod,1] + string
          number    = (number - mod)/base
        end
        alpha[number,1] + string
      end

    private
      def init_private_key
        @private_key = curve.private_key.to_hex
      end

      def init_public_key
        @public_key = curve.public_key.to_hex
      end

      def nil_private_key
        @private_key = nil
        nil_public_key
      end

      def nil_public_key
        @address    = nil
        @public_key = nil
      end
  end
end
