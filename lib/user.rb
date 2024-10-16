# frozen_string_literal: true

# Class for acquisition data about User and prevent errors by loading from the files
class User
  ATTRIBUTES = %w[id first_name last_name email company_id email_status active_status tokens].freeze
  attr_accessor :id, :first_name, :last_name, :email, :company_id, :email_status, :active_status, :tokens

  def initialize(attributes)
    @id = attributes['id']
    @first_name = attributes['first_name']
    @last_name = attributes['last_name']
    @email = attributes['email']
    @company_id = attributes['company_id']
    @email_status = attributes['email_status']
    @is_active = attributes['active_status']
    @tokens = attributes['tokens']
  end

  def to_s
    "#{last_name}, #{first_name}, #{email}"
  end

  class << self
    def loader(file_path)
      data = load_json(file_path)
      data.map { |user_data| new(user_data) } # Create instances for each user
    end

    private

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

    def validate_data(data)
      # Specific validation logic for User
      raise "Expected an Array but got #{data.class}" unless data.is_a?(Array)

      missing_keys = data.flat_map do |user|
        ATTRIBUTES.reject { |key| user.key?(key) }
      end.uniq
      raise "Missing required keys: #{missing_keys.join(', ')}" unless missing_keys.empty?

      data
    end
  end
end
