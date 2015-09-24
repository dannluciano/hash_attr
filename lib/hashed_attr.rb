require 'forwardable'

module HashedAttr
  require 'hashed_attr/version'
  require 'hashed_attr/encryptor'
  require 'hashed_attr/base'
  require 'hashed_attr/active_record' if defined?(ActiveRecord)

  class << self
    extend Forwardable
    def_delegators Base, :encryptor, :encryptor=
  end

  def self.included(target)
    target.send :include, Base
  end
end
