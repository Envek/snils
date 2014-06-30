СНИЛС
=====

Генерация, валидация и форматирование [СНИЛС] (Страхового номера индивидуального лицевого счёта).

[Read this README in English (Читать это README на английском)](README.ru.md)

## Установка

Добавьте следующую строчку в Gemfile в вашем приложении:

    gem 'snils'

И затем выполните:

    $ bundle

Или установите вручную:

    $ gem install snils

## Использование

Генерирование новых СНИЛСов:

```ruby
Snils.new.formatted
#=> "216-471-647 63"
```

Проверка корректности СНИЛСов:

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

Валидация в Ruby on Rails для атрибутов моделей:

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

Генерация СНИЛСов в фабриках для тестов:

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

## Помощь в разработке

1. Сделайте форк проекта в своём github-аккаунте. ( https://github.com/Envek/snils/fork )
2. Создайте отдельную ветвь разработки. (`git checkout -b my-new-feature`)
3. Внесите в неё желаемые изменения (не забудьте про тесты!) и сделайте коммит(ы). (`git commit -am 'Add some feature'`)
4. Запушьте изменения (`git push origin my-new-feature`)
5. Создайте новый Pull Request

[СНИЛС]: http://ru.wikipedia.org/wiki/%D0%A1%D1%82%D1%80%D0%B0%D1%85%D0%BE%D0%B2%D0%BE%D0%B9_%D0%BD%D0%BE%D0%BC%D0%B5%D1%80_%D0%B8%D0%BD%D0%B4%D0%B8%D0%B2%D0%B8%D0%B4%D1%83%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B3%D0%BE_%D0%BB%D0%B8%D1%86%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE_%D1%81%D1%87%D1%91%D1%82%D0%B0
