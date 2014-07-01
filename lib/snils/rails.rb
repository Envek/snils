require 'snils'

# SNILS validation for Active Model (Active Record and Ruby on Rails)
#
# Usage:
#
# 1. Modify your gemfile to require 'snils/rails'
#
#     gem 'snils', require: 'snils/rails'
#
# 2. Add +:snils+ validation to SNILS attributes
#
#    validates :snils, presence: true, uniqueness: true, snils: true
#
class SnilsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    snils = Snils.new(value)
    if snils.errors.any? && options[:message]
      record.errors.add(attribute, options[:message])
    else
      snils.errors.each do |error|
        record.errors.add(attribute, *error)
      end
    end
  end
end
