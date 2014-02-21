module RubyCoin
  class Base
    attr_accessor :curve, :private_key, :public_key

    def initialize(seed, *args)
      self.curve  = ::OpenSSL::PKey::EC.new(seed, *args)

      curve.generate_key
      curve.private_key? ? init_private_key : nil_private_key
      curve.public_key?  ? init_public_key  : nil_public_key
    end

    alias_method :secret, :private_key

    protected
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

      def number_to_base(number, alpha)
        string, base = '', alpha.size
        while(number >= base)
          mod       = number % base
          string    = alpha[mod,1] + string
          number    = (number - mod)/base
        end
        alpha[number,1] + string
      end
  end
end
