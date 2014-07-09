require 'rspec'
require 'snils'

describe Snils do

  # DISCLAIMER: All SNILS used there ARE GENERATED AND RANDOM. Any coincidences are accidental.

  describe '#initialize' do

    it 'should initialize with formatted snils' do
      snils = described_class.new('963-117-158 08')
      expect(snils.raw).to eq('96311715808')
    end

    it 'should initialize with unformatted snils' do
      snils = described_class.new('96311715808')
      expect(snils.raw).to eq('96311715808')
    end

    it 'should initialize with numeric snils' do
      snils = described_class.new(963_117_158_08)
      expect(snils.raw).to eq('96311715808')
    end

    it 'should generate new snils if nothing provided' do
      snils = described_class.new
      expect(snils.raw.length).to eq(11)
      expect(snils.valid?).to be true
    end

  end

  describe '#valid?' do

    it 'should validate valid snils' do
      snils = described_class.new('963-117-158 08')
      expect(snils.valid?).to be true
    end

    it 'should not validate invalid snils (with wrong checksum)' do
      snils = described_class.new('963-117-158 00')
      expect(snils.valid?).to be false
    end

    it 'should not validate invalid snils (with wrong length)' do
      snils = described_class.new('963-117-158 000')
      expect(snils.valid?).to be false
    end

    it 'should not validate invalid snils (with wrong length)' do
      snils = described_class.new('963-117-158')
      expect(snils.valid?).to be false
    end

  end

  describe '#errors' do

    it 'should return empty array for valid snils' do
      snils = described_class.new('963-117-158 08')
      expect(snils.errors).to eq []
    end

    it 'should not validate invalid snils (with wrong checksum)' do
      snils = described_class.new('963-117-158 00')
      expect(snils.errors).to include :invalid
    end

    it 'should not validate invalid snils (with wrong length)' do
      snils = described_class.new('963-117-158 080')
      expect(snils.errors).to include [:wrong_length, { :count => 11 }]
    end

    it 'should not validate invalid snils (with wrong length)' do
      snils = described_class.new('963-117-158')
      expect(snils.errors).to include [:wrong_length, { :count => 11 }]
    end

  end

  describe '#checksum' do

    it 'calculates valid checksum' do
      snils = described_class.new('96311715808')
      expect(snils.checksum).to eq('08')
      snils = described_class.new('83568300320')
      expect(snils.checksum).to eq('20')
      snils = described_class.new('61310200300')
      expect(snils.checksum).to eq('00')
    end

    it 'calculates valid checksum even for invalid snils' do
      snils = described_class.new('96311715800')
      expect(snils.checksum).to eq('08')
    end

    it 'calculates valid checksum even for incomplete snils' do
      snils = described_class.new('188299822')
      expect(snils.checksum).to eq('50')
      snils = described_class.new('563-725-063')
      expect(snils.checksum).to eq('00')
    end

  end

  describe '#formatted' do
    it 'outputs formatted snils' do
      snils = described_class.new('96311715808')
      expect(snils.formatted).to eq('963-117-158 08')
    end
  end

  describe '.generate' do
    it 'generates valid snils' do
      expect(described_class.valid?(described_class.generate)).to be true
    end
  end

  describe '.validate' do
    it 'validates valid snils' do
      expect(described_class.valid?(described_class.generate)).to be true
    end
  end

end
