# frozen_string_literal: true

require 'pp'
require 'qwack'

class UserType
  extend Qwack::BaseHash

  add_attribute 'id', type: Qwack::Types::Integer

  add_attribute 'name', type: Qwack::Types::String
  add_attribute 'email', type: Qwack::Types::Email, mock: 'user@app.me'
  add_attribute 'alias', type: Qwack::Types::String, optional: true

  add_attribute 'active', type: Qwack::Types::Boolean, mock: true
  add_attribute 'ratio', type: Qwack::Types::Float
  add_attribute 'parent', type: Qwack::Types::Integer, null: true
end

pp(UserType.mock({ 'id' => 42, 'name' => 'Bob' }))
# Prints:
# {
#  "id"=>42,
#  "name"=>"Bob",
#  "email"=>"user@app.me",
#  "alias"=>"",
#  "active"=>true,
#  "ratio"=>0.0,
#  "parent"=>0
# }

UserType.validate!(mocked_user)
# No exception, returns the input

UserType.validate!({ 'id' => 42, 'name' => 'Bob' })
# Raises exception:
# Found the following errors: (Qwack::Errors::ValidationError)
# [
#  {:path=>"root", :name=>"UserType", :desc=>"Missing non-optional key", :item=>"email"},
#  {:path=>"root", :name=>"UserType", :desc=>"Missing non-optional key", :item=>"active"},
#  {:path=>"root", :name=>"UserType", :desc=>"Missing non-optional key", :item=>"ratio"},
#  {:path=>"root", :name=>"UserType", :desc=>"Missing non-optional key", :item=>"parent"}
# ]
