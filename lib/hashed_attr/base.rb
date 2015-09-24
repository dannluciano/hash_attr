module HashedAttr
  module Base
    def self.included(target)
      target.extend(ClassMethods)
    end

    class << self
      # Define the object that will encrypt/decrypt values.
      # By default, it's HashedAttr::Encryptor
      attr_accessor :encryptor
    end

    # Set initial encryptor engine.
    self.encryptor = HashedAttr::Encryptor

    module ClassMethods
      def hashed_attr(*args)

        args.each do |attribute|
          define_hashed_attribute(attribute)
        end
      end

      private

      def define_hashed_attribute(attribute)
        define_method attribute do
          instance_variable_get("@#{attribute}")
        end

        define_method "#{attribute}=" do |value|
          instance_variable_set("@#{attribute}", value)
          send("hashed_#{attribute}=", nil)
          send("hashed_#{attribute}=", HashedAttr.encryptor.encrypt(value)) if value
        end
      end
    end
  end
end
