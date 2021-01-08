require "param_cryptable/version"

module ParamCryptable
  extend ActiveSupport::Concern

  class Error < StandardError; end

    extend ActiveSupport::Concern

    included do
      delegate :crypt_params, to: :class
    end

    # Encrypt any value for use by crypt_params
    #
    # @param [Object] text The text to encrypt. This method calls `.to_s` on it.
    # @return [String] The encrypted representation
    def self.encrypt(text)
      cipher = OpenSSL::Cipher.new('blowfish').encrypt
      cipher.key = Rails.application.credentials.param_cryptable_key

      s = cipher.update(text.to_s) + cipher.final
      s.unpack1('H*')
    end

    class_methods do
      # attr_accessor really needs a default / initial value setting...
      #
      # @return [Array] Crypt Params stored in class instance variable.
      def crypt_params
        @crypt_params ||= []
      end

      # Expect this param to be encrypted, if present, and attempt to decrypt it before accessing
      #
      # @param [Symbol, Hash] param The parameter to expect to be crypted
      # @param [Array] tree Internally used for recursion
      def crypt_param(param, tree = [])
        if param.is_a?(Hash)
          key, value = param.first
          crypt_param(value, tree + [key])
        else
          crypt_params << tree + [param]
        end
      end
    end

    # Encrypt any value for use by crypt_params
    #
    # @param [Object] text The text to encrypt. This method calls `.to_s` on it.
    # @return [String] The encrypted representation
    def encrypt(text)
      ParamCryptable.encrypt(text)
    end

    private

    # Override for ActionController#params that decrypts all registered crypt_params if they are
    # provided as strings in the request.
    #
    # @return [ActionController::Parameters]
    def params
      @params ||= super.tap do |params|
        crypt_params.each do |crypt_param|
          local_params =
            if crypt_param.size > 1
              params.dig(*crypt_param[0..-2])
            else
              params
            end
          if local_params[crypt_param.last].is_a? String
            local_params[crypt_param.last] = decrypt(local_params[crypt_param.last])
          end
        end
      end
    end

    def decrypt(code)
      cipher = OpenSSL::Cipher.new('blowfish').decrypt
      cipher.key = Rails.application.credentials.param_cryptable_key
      s = [code].pack('H*').unpack('C*').pack('c*')

      cipher.update(s) + cipher.final
    end

end
