require 'digest/sha2'
require 'base64'

module HashAttr
  class Encryptor
    def self.encrypt(value)
      new().encrypt(value)
    end

    def self.decrypt(value)
      new().decrypt(value)
    end

    def encrypt(value)
      Digest::SHA512.base64digest value
    end

    def decrypt(value)
      value
    end

  end
end
