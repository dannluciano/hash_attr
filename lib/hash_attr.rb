require 'forwardable'

module HashAttr
  require 'hash_attr/version'
  require 'hash_attr/encryptor'
  require 'hash_attr/base'
  require 'hash_attr/active_record' if defined?(ActiveRecord)

  class << self
    extend Forwardable
    def_delegators Base,  :encryptor, :encryptor=
  end

  def self.included(target)
    target.send :include, Base
  end
end
