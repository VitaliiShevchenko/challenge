# frozen_string_literal: true

require 'rspec'
require_relative '../lib/company'
require 'json'

RSpec.describe 'Company' do
  let(:valid_data) { { 'id' => 1, 'name' => 'Blue Cat Inc.', 'top_up' => 71, 'email_status' => 'false' } }
  let(:valid_data_array) { [valid_data] }
  let(:invalid_data) { [ { 'id' => 1, 'name' => 'Blue Cat Inc.' } ] } # Missing required keys
  describe '.initialize' do
    it 'correctly initializes attributes' do
      company = Company.new(valid_data)
      expect(company.id).to eq(1)
      expect(company.name).to eq('Blue Cat Inc.')
      expect(company.top_up).to eq(71)
      expect(company.email_status).to eq('false')
    end
  end

  describe '.loader' do
    let(:file_path) { '../data/input/companies.json' }

    before do
      allow(File).to receive(:read).with(file_path).and_return(valid_data_array.to_json)
    end

    it 'loads valid JSON data and returns an array of Company instances' do
      companies = Company.loader(file_path)
      expect(companies.size).to eq(1)

      expect(companies[0].id).to eq(1)
      expect(companies[0].name).to eq('Blue Cat Inc.')
    end

    it 'handles JSON parsing errors' do
      allow(File).to receive(:read).with(file_path).and_return('{invalid_json}')
      expect { Company.loader(file_path) }.to output(/Error parsing JSON/).to_stdout
    end

    it 'handles missing required keys' do
      allow(File).to receive(:read).with(file_path).and_return(invalid_data.to_json)
      expect { Company.loader(file_path) }.to output("Error loading data from ../data/input/companies.json: Missing required keys: top_up, email_status\n").to_stdout
    end
  end
end
