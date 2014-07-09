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
# Be aware of fact, that this validation doesn't require the value presence,
# use <tt>presence: true</tt> to require SNILS to be present.
#
class SnilsValidator < ActiveModel::EachValidator
  # Validates each attribute to be a SNILS:
  # have 11 digits in itself (punctuation doesn't count) and have valid checksum
  def validate_each(record, attribute, value)
    return  if value.blank?
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
