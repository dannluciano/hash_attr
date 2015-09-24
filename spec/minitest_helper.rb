require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'bundler/setup'
require 'active_record'
require 'hashed_attr'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define(version: 0) do
  create_table :users do |t|
    t.text :hashed_api_key
  end
end
