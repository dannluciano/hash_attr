# HashedAttr

[![Build Status](https://travis-ci.org/fnando/encrypt_attr.svg)](https://travis-ci.org/fnando/encrypt_attr)

Hashed attributes using SHA512 (or your custom hash strategy). Works with and without ActiveRecord.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hashed_attr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hashed_attr

## Usage

The most basic usage is including the `HashedAttr` module.

```ruby
class User
  include HashedAttr
  attr_accessor :hashed_api_key
  hashed_attr :api_key
end
```

This assumes that you have a `hashed_api_key` attribute.

To access the hashed value, just use the method with the same name.

```ruby
user = User.new
user.api_key = 'abc123'
user.api_key                #=> abc123
user.hashed_api_key      #=> xwtd2ev7b1HQnUEytxcMnS...

user.api_key = 'newsecret'
user.api_key                #=> newsecret
user.encrypted_api_key      #=> 6JI/kRYgIF5g1KW5LhQu1j7g4eAC+...
```

You hash multiple attributes at once.

```ruby
class User
  include HashedAttr
  attr_accessor :hashed_api_key, :api_client_id
  hashed_attr :api_key, :api_client_id
end
```

### ActiveRecord integration

You can also use hashed attributes with ActiveRecord. If ActiveRecord is available, it's included automatically. You can also manually include `HashedAttr::Base` or require `hashed_attr/activerecord`.

```ruby
class User < ActiveRecord::Base
  hashed_attr :api_key
end
```

The usage is pretty much the same, and you can set a secret for each attribute. The example above will require a column name `hashed_api_key`.

```ruby
class AddHashedApiKeyToUsers < ActiveRecord::Base
  def change
    add_column :users, :hashed_api_key, :text, null: false
  end
end
```

### Using a custom Hashing

You can define your hash engine by defining an object that responds to `encrypt(value)` and `decrypt(value)`. Here's an example:

```ruby
module SHA256Hash
  def self.encrypt(value)
    Digest::SHA256.base64digest value
  end

  def self.decrypt(value)
    value
  end
end

HashedAttr.encryptor = SHA256Hash

class User
  include HashedAttr
  attr_accessor :hashed_api_key
  attr_hashed :api_key
end

user = User.new
user.api_key = 'API_KEY'
user.hashed_api_key #=> 'zK5tkSpBv+/Vaad7XNhmA83pLlPN1FgTy6nlvwgLNzQ='
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/dannluciano/hashed_attr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Thanks
Many :claps: for Nando Vieira [Twitter](https://twitter.com/fnando), [Github](https://github.com/fnando).
This project is inspired by [EncrypAttr](https://github.com/fnando/encrypt_attr/).
