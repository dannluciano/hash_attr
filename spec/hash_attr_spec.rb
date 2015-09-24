require 'minitest_helper'

describe HashAttr do

  it 'encrypts one attribute' do
    hashed_api_key = HashAttr::Encryptor.encrypt('API_KEY')

    klass = create_class do
      attr_accessor :hashed_api_key
      hash_attr :api_key
    end

    instance = klass.new(api_key: 'API_KEY')

    instance.api_key.must_equal('API_KEY')
    instance.hashed_api_key.wont_be_nil
    instance.hashed_api_key.must_equal(hashed_api_key)
  end

  it 'encrypts multiple attributes' do
    hashed_api_key = HashAttr::Encryptor.encrypt('API_KEY')

    hashed_api_client_id = HashAttr::Encryptor.encrypt('API_CLIENT_ID')

    klass = create_class do
      attr_accessor :hashed_api_key, :hashed_api_client_id
      hash_attr :api_key, :api_client_id
    end

    instance = klass.new(api_key: 'API_KEY', api_client_id: 'API_CLIENT_ID')

    instance.api_key.must_equal('API_KEY')
    instance.api_client_id.must_equal('API_CLIENT_ID')

    instance.hashed_api_key.must_equal(hashed_api_key)
    instance.hashed_api_client_id.must_equal(hashed_api_client_id)
  end

  it 'updates encrypted value' do
    klass = create_class do
      attr_accessor :hashed_api_key
      hash_attr :api_key
    end

    instance = klass.new(api_key: 'API_KEY')
    hashed_api_key = instance.hashed_api_key

    instance.api_key = 'NEW_API_KEY'

    instance.api_key.must_equal('NEW_API_KEY')

    new_hashed_api_key = HashAttr::Encryptor.encrypt('NEW_API_KEY')

    instance.hashed_api_key.must_equal(new_hashed_api_key)
  end

  it 'skips nil values' do
    klass = create_class do
      attr_accessor :hashed_api_key
      hash_attr :api_key
    end

    instance = klass.new(api_key: 'API_KEY')
    instance.api_key = nil
    instance.api_key.must_be_nil
    instance.hashed_api_key.must_be_nil
  end

  def create_class(&block)
    Class.new {
      include HashAttr
      instance_eval(&block)

      def initialize(options = {})
        options.each {|k, v| public_send("#{k}=", v) }
      end
    }
  end
end
