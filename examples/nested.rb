# frozen_string_literal: true

require 'pp'
require 'qwack'

# A hash representing a country
class CountryType
  extend Qwack::BaseHash

  add_attribute 'code', type: Qwack::Types::String, mock: 'US'
  add_attribute 'name', type: Qwack::Types::String, mock: 'United States'
  add_attribute 'flag', type: Qwack::Types::String, optional: true, mock: '🇺🇸'
end

# A hash representing a continent
class ContinentType
  extend Qwack::BaseHash

  add_attribute 'name', type: Qwack::Types::String, mock: 'America'
  add_attribute 'countries', type: Qwack::Meta.array_of(CountryType)
end

pp(ContinentType.mock)
# Prints:
# {"name" => "America", "countries"=>[]}

ContinentType.validate!(
  {
    'name' => 'Europe',
    'countries' => [
      { 'code' => 'de', 'name' => 'Germany', 'flag' => '🇩🇪' },
      { 'code' => 'fr', 'name' => 'France', 'flag' => '🇫🇷' },
      { 'code' => 'es', 'name' => 'Spain' }
    ]
  }
)
# No exception, returns the input

ContinentType.validate!(
  {
    'name' => 'Asia',
    'countries' => [
      { 'code' => 'jp', 'flag' => '🇯🇵' },
      { 'code' => 42, 'name' => 'China', 'flag' => '🇨🇳' }
    ]
  }
)
# Raises with:
# Found the following errors: (Qwack::Errors::ValidationError)
# [
#  {:path=>"root.countries.0", :name=>"CountryType", :desc=>"Missing non-optional key", :item=>"name"},
#  {:path=>"root.countries.1.code", :name=>"Qwack::Types::String", :desc=>"Not a string", :item=>42}
# ]
