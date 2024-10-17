# frozen_string_literal: true

# Class for acquisition data about Company
class Company
  ATTRIBUTES = %w[id name top_up email_status].freeze
  attr_accessor :id, :name, :top_up, :email_status

  def initialize(attributes)
    @id = attributes['id']
    @name = attributes['name']
    @top_up = attributes['top_up']
    @email_status = attributes['email_status']
  end

  class << self
    # Handler for safe loading data from the files
    def loader(file_path)
      data = load_json(file_path)
      data.map { |company_data| new(company_data) } # Create instances for each company
    end

    private

    # prevent errors by loading data  from the files that assignment for Company
    def load_json(file_path)

      data = JSON.parse(File.read(file_path))
      validate_data(data)
    rescue JSON::ParserError => e
      puts "Error parsing JSON from #{file_path}: #{e.message}"
      []
    rescue StandardError => e
      puts "Error loading data from #{file_path}: #{e.message}"
      []

    end

    # Specific validation logic for Company
    def validate_data(data)
      raise "Expected an Array but got #{data.class}" unless data.is_a?(Array)

      missing_keys = data.flat_map do |company|
        ATTRIBUTES.reject { |key| company.key?(key) }
      end.uniq
      raise "Missing required keys: #{missing_keys.join(', ')}" unless missing_keys.empty?

      data
    end
  end
end
