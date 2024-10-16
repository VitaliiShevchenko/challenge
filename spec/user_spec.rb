# frozen_string_literal: true

require 'rspec'
require_relative '../lib/user'
require 'json'

RSpec.describe 'User' do
  let(:valid_data) do
    {		'id' => 1,
       'first_name' => 'Tanya',
       'last_name' => 'Nichols',
       'email' => 'tanya.nichols@test.com',
       'company_id' => 2,
       'email_status' => true,
       'active_status' => false,
       'tokens' => 23 }
  end
  let(:valid_data_array) { [valid_data] }
  let(:invalid_data) { [{ 'id' => 1, 'first_name' => 'Tanya' }] } # Missing required keys
  describe '.initialize' do
    it 'correctly initializes attributes' do
      user = User.new(valid_data)
      expect(user.id).to eq(1)
      expect(user.first_name).to eq('Tanya')
      expect(user.last_name).to eq('Nichols')
      expect(user.email).to eq('tanya.nichols@test.com')
      expect(user.company_id).to eq(2)
      expect(user.email_status).to be_truthy
      expect(user.active_status).to be_falsey
      expect(user.tokens).to eq(23)
    end
  end

  describe '.loader' do
    let(:file_path) { '../data/input/users.json' }

    before do
      allow(File).to receive(:read).with(file_path).and_return(valid_data_array.to_json)
    end

    it 'loads valid JSON data and returns an array of User instances' do
      users = User.loader(file_path)
      expect(users.size).to eq(1)

      expect(users[0].id).to eq(1)
      expect(users[0].first_name).to eq('Tanya')
    end

    it 'handles JSON parsing errors' do
      allow(File).to receive(:read).with(file_path).and_return('{invalid_json}')
      expect { User.loader(file_path) }.to output(/Error parsing JSON/).to_stdout
    end

    it 'handles missing required keys' do
      allow(File).to receive(:read).with(file_path).and_return(invalid_data.to_json)
      expect { User.loader(file_path) }.to output("Error loading data from ../data/input/users.json: Missing required keys: last_name, email, company_id, email_status, active_status, tokens\n").to_stdout
    end
  end
end
