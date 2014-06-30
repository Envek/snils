SNILS
=====

[![Gem Version](https://badge.fury.io/rb/snils.svg)](http://badge.fury.io/rb/snils)
[![Continuous Integration status](https://api.travis-ci.org/Envek/snils.svg)](http://travis-ci.org/Envek/snils)

Generating, validating and formatting [SNILS] number (Russian pension insurance individual account number).

Генерация, валидация и форматирование СНИЛС (Страхового номера индивидуального лицевого счёта).

[Read this README in Russian (Читать это README на русском)](README.ru.md)

## Installation

Add this line to your application's Gemfile:

    gem 'snils'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snils

## Usage

Generate new SNILS:

```ruby
Snils.new.formatted
#=> "216-471-647 63"
```

Validate SNILS:

```ruby
Snils.new("21647164763").valid?
#=> true

Snils.new("21647164760").valid?
#=> false

Snils.new("21647164760").errors
#=> [:invalid]

Snils.new("216471647").errors
#=> [[:wrong_length, {:count=>11}], :invalid]
```

Validating Rails model attributes:

```ruby
require 'snils'

class User < ActiveRecord::Base
  validates :snils, presence: true, uniqueness: true
  validate  :snils_validation
  
  protected
  
  def snils_validation
    validated_snils = Snils.new(snils)
    unless validated_snils.valid?
      validated_snils.errors.each do |error|
        errors.add(:snils, *error)
      end
    end
  end
end
```

Generating SNILSes in factories for tests:

```ruby
FactoryGirl.define do
  sequence :snils do |_|
    Snils.new.to_s
  end

  factory :user do
    snils
  end
end
```

## Contributing

1. Fork it ( https://github.com/Envek/snils/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[SNILS]: http://en.wikipedia.org/wiki/SNILS_(Russia) "Insurance individual account number"
