SNILS
=====

[![Gem Version](https://badge.fury.io/rb/snils.svg)](http://badge.fury.io/rb/snils)
[![Continuous Integration status](https://api.travis-ci.org/Envek/snils.svg)](http://travis-ci.org/Envek/snils)
[![PullReview stats](https://www.pullreview.com/github/Envek/snils/badges/master.svg?)](https://www.pullreview.com/github/Envek/snils/reviews/master)

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

 1. Modify your gemfile to require `snils/rails`

    ```ruby
    gem 'snils', require: 'snils/rails'
    ```

 2. Add `:snils` validation to SNILS attributes

    ```ruby
    validates :snils, presence: true, uniqueness: true, snils: true
    ```

Generating SNILSes in factories for tests:

```ruby
FactoryGirl.define do
  # You can generate random valid SNILSes
  sequence :snils do |_|
    Snils.generate
  end
  # Or sequenced ones
  sequence :snils do |counter|
    Snils.generate(counter)
  end

  factory :user do
    snils
  end
end
```

### Recommended workflow for Ruby on Rails projects

 1. Use [draper] gem to format SNILS for views

    ```ruby
    # app/decorators/user_decorator.rb
    class UserDecorator < Draper::Decorator
      delegate_all

      def snils
        @formatted_snils ||= Snils.new(object.snils).formatted
      end
    end
    ```

 2. Sanitize SNILSes on attribute write

    ```ruby
    # app/models/user.rb
    class User < ActiveRecord::Base
      validates :snils, presence: true, uniqueness: true, snils: true

      def snils=(value)
        write_attribute(:snils, Snils.new(value).raw)
      end
    end
    ```

With this setup you will always store raw (only digits) value in database and always will show pretty formatted SNILS to users.


## Contributing

1. Fork it ( https://github.com/Envek/snils/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[draper]: https://github.com/drapergem/draper
[SNILS]: http://en.wikipedia.org/wiki/SNILS_(Russia) "Insurance individual account number"
