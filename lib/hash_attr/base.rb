module HashAttr
  module Base
    def self.included(target)
      target.extend(ClassMethods)
    end

    class << self
      # Define the object that will encrypt/decrypt values.
      # By default, it's HashAttr::Encryptor
      attr_accessor :encryptor
    end

    # Set initial encryptor engine.
    self.encryptor = Encryptor

    module ClassMethods
      def hash_attr(*args)

        args.each do |attribute|
          define_encrypted_attribute(attribute)
        end
      end

      private

      def define_encrypted_attribute(attribute)
        define_method attribute do
          instance_variable_get("@#{attribute}")
        end

        define_method "#{attribute}=" do |value|
          instance_variable_set("@#{attribute}", value)
          send("hashed_#{attribute}=", nil)
          send("hashed_#{attribute}=", HashAttr.encryptor.encrypt(value)) if value
        end
      end
    end
  end
end
