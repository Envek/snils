require 'snils/version'

# Generating, validating and formatting SNILS number Russian pension insurance individual account number)
class Snils

  # New object with SNILS +number+ if provided. Otherwise, it generated randomly
  def initialize(number = nil)
    @snils = if number.kind_of? Numeric
               '%011d' % number
             elsif number
               number.to_s.gsub(/[^\d]/, '')
             else
               self.class.generate
             end
    @errors = []
    @validated = false
  end

  # Calculates checksum (last 2 digits) of a number
  def checksum
    digits = @snils.split('').take(9).map(&:to_i)
    checksum = digits.each.with_index.reduce(0) do |sum, (digit, index)|
      sum + digit * (9 - index)
    end
    while checksum > 101 do
      checksum = checksum % 101
    end
    checksum = 0  if (100..101).include?(checksum)
    '%02d' % checksum
  end

  # Validates SNILS. Valid SNILS is a 11 digits long and have correct checksum
  def valid?
    validate  unless @validated
    @errors.none?
  end

  # Validates string with a SNILS. Valid SNILS is a 11 digits long and have correct checksum.
  def self.valid?(snils)
    self.new(snils).valid?
  end

  # Returns SNILS in format 000-000-000 00
  def formatted
    "#{@snils[0..2]}-#{@snils[3..5]}-#{@snils[6..8]} #{@snils[9..10]}"
  end

  # Returns unformatted SNILS (only 11 digits)
  def raw
    @snils
  end
  alias_method :to_s, :raw

  # Returns array with errors if SNILS invalid
  def errors
    validate  unless @validated
    @errors
  end

  # Generates new random valid SNILS
  #
  # if you'll provide +num+, it will be used as a base for new SNILS,
  # checksum will be calculated automatically.
  def self.generate(num = nil)
    digits = num.nil? ? Array.new(9).map { rand(10) }.join : ('%09d' % num)
    sum = self.new(digits).checksum
    "#{digits}#{sum}"
  end

  protected

  def validate
    @errors << [:wrong_length, { :count => 11 }]  unless @snils.length == 11
    @errors << :invalid  unless @snils[-2..-1] == self.checksum
    @validated = true
  end

end
