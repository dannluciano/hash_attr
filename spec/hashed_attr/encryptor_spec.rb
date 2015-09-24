require 'minitest_helper'

describe HashedAttr::Encryptor do
  it 'hash value' do
    hashed = HashedAttr::Encryptor.encrypt('hello')

    hashed.wont_equal('hello')
    hashed.must_equal('m3HSJL1i83hdltRq0+o9czGb+8KJDKra4t/3JRlnPKcjI8PZm6XBHXx6zG4UuMXaDEZjR1wuXDre9G9zvN7AQw==')
  end
end
