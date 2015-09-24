require 'hashed_attr'
ActiveRecord::Base.send :include, HashedAttr::Base
