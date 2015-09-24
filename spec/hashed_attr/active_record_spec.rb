require 'minitest_helper'

describe HashedAttr, 'ActiveRecord support' do
  it 'includes module' do
    ActiveRecord::Base.included_modules.must_include(HashedAttr::Base)
  end

  it 'encrypts attributes' do
    model = Class.new(ActiveRecord::Base) {
      self.table_name = 'users'
      hashed_attr :api_key
    }

    hashed_api_key = HashedAttr::Encryptor.encrypt('API_KEY')

    instance = model.create(api_key: 'API_KEY')
    instance.reload

    instance.hashed_api_key.must_equal(hashed_api_key)
    instance.api_key.must_equal('API_KEY')
  end
end
